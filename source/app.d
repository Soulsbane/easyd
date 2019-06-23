import std.stdio;
import std.algorithm;

import scriptsystem;

void main(string[] arguments)
{
	auto scriptSystem = new ScriptSystem;
	string[] args = arguments[1..$];

	if(args.length)
	{
		immutable string commandName = args[0];

		if(commandName.startsWith("--"))
		{
			//writeln("Command line param");
		}
		else
		{
			string[] commands;

			if(args.length > 1) // Command has arguments
			{
				commands = args[1..$];
				scriptSystem.addAdditionalCommands(commands);
			}

			scriptSystem.loadScripts();
			scriptSystem.runCommand(commandName);
		}
	}
	else
	{
		///No command line arguments
	}

}

