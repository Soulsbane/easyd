module api;

import arsd.jsvar;

mixin template APIFunctions()
{
	void registerAPIFunctions()
	{
		registerFunction!"getDubVersion";
		registerFunction!"isInstalled";
	}

	auto getDubVersion()
	{
		return "1.15";
	}

	bool isInstalled()
	{
		return true;
	}
}
