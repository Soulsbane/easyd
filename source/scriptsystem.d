module scriptsystem;

import std.stdio;
import std.path;
import std.file;

import arsd.script;
import arsd.jsvar;

import api;
import utils;
import commands;

class BaseScriptSystem
{
	mixin StdFunctions;

	this()
	{
		// Standard Library Functions.
		registerStdFunctions();
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

private:
	var globals_ = var.emptyObject;
}

class ScriptSystem : BaseScriptSystem
{
	this()
	{
		registerFunction!"getDubVersion";
		registerCommandFunction!"addCommand";
		registerCommandFunction!"getAdditionalCommands";
		registerCommandFunction!"isCommandNameAvailable";
	}

	void registerCommandFunction(alias name)()
	{
		immutable func = "globals_." ~ name ~ " = &commands_." ~ name ~ ";";
		mixin(func);
	}

	Commands getCommands()
	{
		return commands_;
	}

private:
	Commands commands_;
}
