module utils;

import std.stdio;
import std.algorithm;
import std.array;
public import std.file : SpanMode, dirEntries, DirEntry;

import arsd.jsvar;
import register;

void registerStdFunctions(var funcs)
{
	mixin(registerFunction!"print");
	mixin(registerFunction!"printLn");
}

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
