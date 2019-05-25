module api;

import arsd.jsvar;
import register;

void registerAPIFunctions(var funcs)
{
	mixin(registerFunction!"getDubVersion");
	mixin(registerFunction!"isExeAvailable");
}

auto getDubVersion()
{
	return "1.15";
}

bool isExeAvailable()
{
	return true;
}
