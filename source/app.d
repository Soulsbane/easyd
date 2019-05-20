import std.stdio;
import std.file;
import std.algorithm;
import std.array;

import arsd.script;
import arsd.jsvar;

var ScriptSystem_ = var.emptyObject;
string[string] Commands_;

auto getDubVersion()
{
	return "1.15";
}

void setupScriptEvironment()
{
	ScriptSystem_.addCommand = &addCommand;
	ScriptSystem_.getDubVersion = &getDubVersion;
}

void addCommand(const string name, const string command)
{
	if(name in Commands_)
	{
		writeln("Command name already in use!");
	}
	else
	{
		Commands_[name] = command;
	}
}

string loadScripts()
{
	auto commands = getDirList("./commands", SpanMode.shallow);

	return string.init;
}

auto getDirList(const string name, SpanMode mode)
{
	auto dirs = dirEntries(name, mode)
		.filter!(a => a.isFile && !a.name.startsWith("."))
		.array;

	return sort(dirs);
}

void main(string[] arguments)
{
	auto commands = arguments[1..$];

	setupScriptEvironment();
	writeln("Length = ", commands.length);

	if(commands.length > 1)
	{
		writeln(commands[1]);
	}
}

