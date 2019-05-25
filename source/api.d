module api;

import arsd.jsvar;
import register;

void registerAPIFunctions(var funcs)
{
	mixin(registerFunction!"getDubVersion");
	mixin(registerFunction!"isInstalled");
}

auto getDubVersion()
{
	return "1.15";
}

bool isInstalled()
{
	return true;
}
