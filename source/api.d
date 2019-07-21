module api;

import arsd.jsvar;
import dpathutils.exists;

auto getDubVersion()
{
	import std.process : execute;
	import std.array : split;
	import std.algorithm : findSplitBefore;

	auto dubOutput = execute(["dub", "--version"]);
	return dubOutput.output.findSplitBefore(",")[0].split[2];
}

bool isInstalled(const string executableName)
{
	if(isInPath(executableName))
	{
		return true;
	}

	return false;
}
