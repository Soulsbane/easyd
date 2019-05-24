module scriptsystem;

import std.stdio;

import arsd.script;
import arsd.jsvar;

import api;
import utils;

class ScriptSystem
{
	this()
	{
		// Standard Library Functions.
		globals_.print = &print;
		globals_.printLn = &printLn;

		globals_.addCommand = &addCommand;
		globals_.getDubVersion = &getDubVersion;
		globals_.getAddtionalCommands = &getAddtionalCommands;
		globals_.isCommandNameAvailable = &isCommandNameAvailable;
	}

	void setupAdditionalCommands(string[] additionalCommands)
	{
		additionalCommands_ = additionalCommands;
	}

	string[] getAddtionalCommands()
	{
		return additionalCommands_;
	}

	void addCommand(const string name, const string command)
	{
		if(name in commands_)
		{
			writeln("Command ", name, "already in use!");
		}
		else
		{
			debug writeln("Added Command: ", name);
			commands_[name] = command;
		}
	}

	bool isCommandNameAvailable(const string name)
	{
		if(name in commands_)
		{
			return false;
		}

		return true;
	}

	void dumpCommands()
	{
		foreach(key, value; commands_)
		{
			writeln(key, " => ", value);
		}
	}

	void loadScripts()
	{
		auto files = getDirList("commands", SpanMode.shallow);

		foreach(file; files)
		{
			interpretFile(File(file.name), globals_);
		}
	}

private:
	var globals_ = var.emptyObject;
	string[string] commands_;
	string[] additionalCommands_;
}
