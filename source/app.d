import std.stdio;
import std.algorithm;

import scriptsystem;
import dapplicationbase;

struct EasyOptions
{
	@GetOptOptions("The executable to send commands to.", "p", "prefix")
	string prefix;
}

class EasyApplication : Application!EasyOptions
{
	this() {}
}

void main(string[] arguments)
{
	auto scriptSystem = new ScriptSystem;
	string[] args = arguments[1..$];

	auto app = new EasyApplication;

	if(args.length)
	{
		immutable string commandName = args[0];

		if(commandName.startsWith("--"))
		{
			app.create("Raijinsoft", "easyd", arguments);
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

