module scriptsystem;

import std.stdio;
import std.conv;
import std.path;
import std.file;
import std.algorithm : each;

import arsd.script;
import arsd.jsvar;

import dscriptsystem.base;

import api;
import utils;
import commands;

class ScriptSystem : BaseScriptSystem
{
	this()
	{
		registerFunction!"getDubVersion";
		registerFunction!"getDmdVersion";
		registerFunction!"getLdcVersion";
		registerFunction!"isInstalled";
		registerFunction!"isDubInstalled";
		registerFunction!"isDmdInstalled";
		registerFunction!"isLdcInstalled";
		//registerFunction("addCommand", &commands_.addCommand);
		registerCommandFunction!"addCommand";
		registerCommandFunction!"getAdditionalCommands";
		registerCommandFunction!"isCommandNameAvailable";
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

	void registerCommandFunction(alias name)()
	{
		immutable func = "globals_." ~ name ~ " = &commands_." ~ name ~ ";";
		mixin(func);
	}

	alias commands_ this;
	Commands commands_;
}
