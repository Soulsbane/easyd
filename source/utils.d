module utils;

public import std.file; // For SpanMode
import std.algorithm;
import std.array;

auto getDirList(const string name, SpanMode mode)
{
	auto dirs = dirEntries(name, mode)
		.filter!(a => a.isFile && !a.name.startsWith("."))
		.array;

	return sort(dirs);
}
