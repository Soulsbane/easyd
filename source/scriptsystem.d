module scriptsystem;

import std.stdio;
import std.conv;
import std.path;
import std.file;

import arsd.script;
import arsd.jsvar;

import api;
import utils;
import commands;

class BaseScriptSystem
{
	void loadScripts(const string scriptsPath = string.init)
	{
		string paths;

		if(scriptsPath)
		{
			paths = scriptsPath;
		}
		else
		{
			paths = buildNormalizedPath(dirName(thisExePath()), "scripts");
		}

		auto files = getDirList(paths, SpanMode.shallow);
		registerStdFunctions();

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
		globals_.write._function = (var _this, var[] args)
		{
			string s;

			foreach(a; args)
			{
				s ~= a.get!string;
			}

			write(s);
			return var(null);
		};

		globals_.writeln._function = (var _this, var[] args)
		{
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

	alias commands_ this;
	Commands commands_;
}
