module api;

import arsd.jsvar;

auto getDubVersion()
{
	import std.process : execute;
	import std.array : split;
	import std.algorithm : findSplitBefore;

	auto dubOutput = execute(["dub", "--version"]);
	return dubOutput.output.findSplitBefore(",")[0].split[2];
}

bool isInstalled()
{
	return true;
}

mixin template StdFunctions()
{
	void registerStdFunctions()
	{
		import std.conv;
		import std.stdio;

		globals_.write._function = (var _this, var[] args) {
			string s;

			foreach(a; args)
			{
				s ~= a.get!string;
			}

			write(s);
			return var(null);
		};

		globals_.writeln._function = (var _this, var[] args) {
			string s;

			foreach(a; args)
			{
				s ~= a.get!string;
			}

			writeln(s);
			return var(null);
		};
	}
}
