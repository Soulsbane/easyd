module utils;

import std.stdio;
import std.algorithm;
import std.array;
import std.process;
import std.typecons;
public import std.file : SpanMode, dirEntries, DirEntry;

import arsd.jsvar;

mixin template StdFunctions()
{
	void registerStdFunctions()
	{
		registerFunction!"print";
		registerFunction!"printLn";
	}

	void print(var args...)
	{
		write(args);
	}

	void printLn(var args...)
	{
		writeln(args);
	}
}

auto getDirList(const string name, SpanMode mode)
{
	auto dirs = dirEntries(name, mode)
		.filter!(a => a.isFile && !a.name.startsWith("."))
		.array;

	return sort(dirs);
}

auto launchApplication(const string application, string[] args = [])
{
	try
	{
		return executeShell(application);
	}
	catch(ProcessException ex)
	{
		return tuple!("status", "output")(-1, ex.msg);
	}

}
