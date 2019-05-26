import std.stdio;
import scriptsystem;

void main(string[] arguments)
{
	auto scriptSystem_ = new ScriptSystem;
	auto commands = arguments[1..$];

	if(commands.length >= 1)
	{
		writeln("Command passed: ", commands[0]);

		if(commands.length > 1)
		{
			scriptSystem_.addAdditionalCommands(commands[1..$]);
		}
		else
		{
			// No arguments passed after command.
		}
	}

	scriptSystem_.loadScripts();
	debug scriptSystem_.dumpCommands();
}

