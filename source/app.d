import std.stdio;
import scriptsystem;

void main(string[] arguments)
{
	auto scriptSystem_ = new ScriptSystem;
	auto commands = arguments[1..$];

	scriptSystem_.loadScripts();

	if(commands.length >= 1)
	{
		immutable string command = commands[0];
		writeln("Command passed: ", command);

		if(commands.length > 1)
		{
			// NOTE: This is just makes the commands arguments available to scripts.
			scriptSystem_.addAdditionalCommands(commands[1..$]);
		}
		else
		{
			// No arguments passed after command.
		}

		scriptSystem_.runCommand(command);
	}

}

