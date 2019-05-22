import std.stdio;

import scriptsystem;

void main(string[] arguments)
{
	auto commands = arguments[1..$];

	writeln("Length = ", commands.length);

	if(commands.length > 1)
	{
		writeln(commands[1]);
	}

	auto scriptSystem_ = new ScriptSystem;
}

