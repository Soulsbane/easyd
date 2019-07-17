module commands;

import std.stdio;
import utils;

struct Commands
{
	void addCommand(const string name, const string command)
	{
		if(name in commands_)
		{
			writeln("Command ", name, "already in use!");
		}
		else
		{
			commands_[name] = command;
		}
	}

	void addAdditionalCommands(string[] additionalCommands)
	{
		additionalCommands_ = additionalCommands;
	}

	string[] getAdditionalCommands()
	{
		return additionalCommands_;
	}

	bool isCommandNameAvailable(const string name)
	{
		if(name in commands_)
		{
			return false;
		}

		return true;
	}

	void runCommand(const string name)
	{
		if(name in commands_)
		{
			immutable string command = baseCommand_ ~ " " ~ commands_[name];
			launchApplication(command);
		}
		else
		{
			writeln("command not found");
		}
	}

	void dumpCommands()
	{
		foreach(key, value; commands_)
		{
			writeln(key, " => ", value);
		}
	}

private:
	string[string] commands_;
	string[] additionalCommands_;
	string baseCommand_ = "dub";
}