import std.stdio;
import scriptsystem;

void main(string[] arguments)
{
	auto scriptSystem = new ScriptSystem;
	string[] args = arguments[1..$];

	if(args.length)
	{
		string commandName = args[0];
		string[] commands;

		if(args.length > 1) // Command has arguments
		{
			commands = args[1..$];
			scriptSystem.addAdditionalCommands(commands);
		}
		else // Only command was passed.
		{
			//writeln("Only the command was passed: ", commandName, " Args: ", commands);
		}

		scriptSystem.loadScripts();
		scriptSystem.runCommand(commandName);
	}
	else
	{
		///No command line arguments
	}
}

