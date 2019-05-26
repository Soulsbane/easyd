import std.stdio;
import scriptsystem;

void main(string[] arguments)
{
	auto scriptSystem_ = new ScriptSystem;
	auto commands = arguments[1..$];

	writeln("Length = ", commands.length);

	if(commands.length == 1)
	{
		writeln(commands[1]);
	}
	else
	{
		scriptSystem_.addAdditionalCommands(commands[0..$]);
		// TODO: Pass the additional commands to the script.
	}


	scriptSystem_.loadScripts();
	debug scriptSystem_.dumpCommands();
}

