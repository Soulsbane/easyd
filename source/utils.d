module utils;

import std.algorithm;
import std.array;
import std.process;
import std.typecons;
public import std.file : FileException, SpanMode, dirEntries, DirEntry;

auto getDirList(const string name, SpanMode mode)
{
	auto dirs = dirEntries(name, mode)
		.filter!(a => a.isFile && !a.name.startsWith("."))
		.array;

	return sort(dirs);
}

auto launchApplication(const string application, string[] args = [])
{
	// FIXME: Should probably rethrow the error!
	try
	{
		auto result = executeShell(application);
		return result;
	}
	catch(ProcessException ex)
	{
		return tuple!("status", "output")(-1, ex.msg);
	}
	catch(FileException ex)
	{
		return tuple!("status", "output")(-2, ex.msg);
	}

}
