import std.stdio;
import std.algorithm;
import std.path;
import std.file;

import scriptsystem;
import api;

void handleCommand(ScriptSystem scriptSystem, const string commandName, string[] args)
{
	immutable string commandsPath = thisExePath.dirName.buildNormalizedPath("commands");
	string[] commands;

	if(args.length > 1) // Command has arguments
	{
		commands = args[1..$];
		scriptSystem.addAdditionalCommands(commands);
	}

	scriptSystem.loadScripts(commandsPath);

	if(args.length)
	{
		scriptSystem.runCommand(commandName);
	}
	else
	{
		scriptSystem.runCommand("release");
	}
}

void main(string[] arguments)
{
	auto scriptSystem = new ScriptSystem;
	string[] args = arguments[1..$];
	string defaultCommandName = "release";// FIXME: Temporary. Will  be used to run last run command if no arguments.

	if(args.length)
	{
		immutable string commandName = args[0];

		if(commandName.startsWith("--"))
		{
			//writeln("Command line param");
		}
		else
		{
			handleCommand(scriptSystem, commandName, args);
		}
	}
	else
	{
		handleCommand(scriptSystem, defaultCommandName, args);
	}
}

