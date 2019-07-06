module api;

import arsd.jsvar;

mixin template APIFunctions()
{
	void registerAPIFunctions()
	{
		registerFunction!"getDubVersion";
		registerFunction!"isInstalled";
	}

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
}
