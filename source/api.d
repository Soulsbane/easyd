module api;

import std.stdio;
import std.process : execute;
import std.array : split;
import std.algorithm;
import std.range : split;

import dpathutils.exists;

auto getDubVersion()
{
	auto dubOutput = execute(["dub", "--version"]);
	return dubOutput.output.findSplitBefore(",")[0].split[2];
}

auto getDmdVersion()
{
	immutable auto output = execute(["dmd", "--version"]);
	return output.output.findSplitAfter("v")[1].split("\n")[0];
}

auto getLdcVersion()
{
	immutable auto output = execute(["ldc2", "--version"]);
	immutable string versionSentence = output.output.split("\n")[0];
	immutable string finalStr = versionSentence[versionSentence.countUntil("(") + 1 .. versionSentence.countUntil(")")];

	return finalStr;
}

bool isInstalled(const string executableName)
{
	if(isInPath(executableName))
	{
		return true;
	}

	return false;
}
