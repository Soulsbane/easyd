module utils;

import std.stdio;

public import std.file : SpanMode, dirEntries, DirEntry;
import std.algorithm;
import std.array;

auto getDirList(const string name, SpanMode mode)
{
	auto dirs = dirEntries(name, mode)
		.filter!(a => a.isFile && !a.name.startsWith("."))
		.array;

	return sort(dirs);
}

void print(const string value)
{
	write(value);
}

void printLn(const string value)
{
	writeln(value);
}
