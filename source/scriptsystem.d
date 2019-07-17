module scriptsystem;

import std.stdio;
import std.path;
import std.file;
import std.conv;

import arsd.script;
import arsd.jsvar;

import api;
import utils;
import commands;

class BaseScriptSystem
{
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

	void registerFunction(T)(const string name, T func)
	{
		globals_[name] = func;
	}

	void registerStdFunctions()
	{
		globals_.write._function = (var _this, var[] args) {
			string s;

			foreach(a; args)
			{
				s ~= a.get!string;
			}

			write(s);
			return var(null);
		};

		globals_.writeln._function = (var _this, var[] args) {
			string s;

			foreach(a; args)
			{
				s ~= a.get!string;
			}

			writeln(s);
			return var(null);
		};
	}

private:
	var globals_ = var.emptyObject;
}

class ScriptSystem : BaseScriptSystem
{
	this()
	{
		registerFunction!"getDubVersion";
		//registerFunction("addCommand", &commands_.addCommand);
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
