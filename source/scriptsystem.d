module scriptsystem;

import std.stdio;
import std.path;
import std.file;

import arsd.script;
import arsd.jsvar;

import api;
import utils;
import commands;

class ScriptSystem
{
	mixin StdFunctions;
	mixin APIFunctions;

	this()
	{
		// Standard Library Functions.
		registerStdFunctions();
		registerAPIFunctions();

		registerFunction!"getDubVersion";
		registerCommandFunction!"addCommand";
		registerCommandFunction!"getAdditionalCommands";
		registerCommandFunction!"isCommandNameAvailable";
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

	void registerCommandFunction(alias name)() // FIXME: Temporary. This should be a base class.
	{
		immutable func = "globals_." ~ name ~ " = &commands_." ~ name ~ ";";
		mixin(func);
	}

	Commands getCommands()
	{
		return commands_;
	}

private:
	var globals_ = var.emptyObject;
	Commands commands_;
}
