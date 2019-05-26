module utils;

import std.stdio;
import std.algorithm;
import std.array;
public import std.file : SpanMode, dirEntries, DirEntry;

import arsd.jsvar;
import register;

mixin template StdFunctions()
{
	void registerStdFunctions()
	{
		registerFunction!"print";
		registerFunction!"printLn";
	}

	void print(const string value)
	{
		write(value);
	}

	void printLn(const string value)
	{
		writeln(value);
	}
}

auto getDirList(const string name, SpanMode mode)
{
	auto dirs = dirEntries(name, mode)
		.filter!(a => a.isFile && !a.name.startsWith("."))
		.array;

	return sort(dirs);
}

