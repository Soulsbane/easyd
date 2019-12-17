import std.stdio;
import std.algorithm;
import std.path;
import std.file;

import scriptsystem;
import api;

void handleCommand(const string commandName, string[] commands)
{
	auto scriptSystem = new ScriptSystem;
	immutable string commandsPath = thisExePath.dirName.buildNormalizedPath("commands");

	scriptSystem.loadScripts(commandsPath);

	if(commands.length)
	{
		scriptSystem.runCommand(commandName, commands);
	}
	else
	{
		if(commandName == "list")
		{
			scriptSystem.listCommands();
		}
		else
		{
			scriptSystem.runCommand(commandName);
		}
	}
}

void main(string[] arguments)
{
	string[] args = arguments[1..$];
	string defaultCommandName = "release";// FIXME: Temporary. Will  be used to run last run command if no arguments.

	if(args.length)
	{
		immutable string commandName = args[0];
		string[] commands = args[1..$];

		handleCommand(commandName, commands);
	}
	else
	{
		handleCommand(defaultCommandName, args);
	}
}

