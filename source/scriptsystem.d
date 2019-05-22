module scriptsystem;

import std.stdio;

import arsd.script;
import arsd.jsvar;

import api;
import utils;

// Use interpretFile(File file, var globals)
class ScriptSystem
{
	this()
	{
		globals_.addCommand = &addCommand;
		globals_.getDubVersion = &getDubVersion;
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
}
