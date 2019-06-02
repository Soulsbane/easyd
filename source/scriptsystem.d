module scriptsystem;

import std.stdio;
import std.path;
import std.file;

import arsd.script;
import arsd.jsvar;

import api;
import utils;

class ScriptSystem
{
	mixin StdFunctions;
	mixin APIFunctions;

	this()
	{
		// Standard Library Functions.
		registerStdFunctions();
		registerAPIFunctions();

		registerFunction!"addCommand";
		registerFunction!"getDubVersion";
		registerFunction!"getAdditionalCommands";
		registerFunction!"isCommandNameAvailable";
	}

	void addAdditionalCommands(string[] additionalCommands)
	{
		additionalCommands_ = additionalCommands;
	}

	string[] getAdditionalCommands()
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
		immutable string commandsPath = buildNormalizedPath(dirName(thisExePath()), "commands");
		auto files = getDirList(commandsPath, SpanMode.shallow);

		foreach(file; files)
		{
			interpretFile(File(file.name), globals_);
		}
	}

	void registerFunction(alias name)()
	{
		immutable func = "globals_." ~ name ~ " = &" ~ name ~ ";";
		mixin(func);
	}

	void runCommand(const string name)
	{
		if(name in commands_)
		{
			immutable string command = baseCommand_ ~ " " ~ commands_[name];
			launchApplication(command);
		}
		else
		{
			writeln("command not found");
		}
	}

private:
	var globals_ = var.emptyObject;
	string[string] commands_;
	string[] additionalCommands_;
	string baseCommand_ = "dub";
}
