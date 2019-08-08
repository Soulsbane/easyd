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
		registerFunction("getDubVersion", &getDubVersion);
		registerFunction("getDmdVersion", &getDmdVersion);
		registerFunction("getLdcVersion", &getLdcVersion);
		registerFunction("isInstalled", &isInstalled);
		registerFunction("isDubInstalled", &isDubInstalled);
		registerFunction("isDmdInstalled", &isDmdInstalled);
		registerFunction("isLdcInstalled", &isLdcInstalled);
		registerFunction("addCommand", &commands_.addCommand);
		registerFunction("getAdditionalCommands", &commands_.getAdditionalCommands);
		registerFunction("isCommandNameAvailable", &commands_.isCommandNameAvailable);
	}

	alias commands_ this;
	Commands commands_;
}
