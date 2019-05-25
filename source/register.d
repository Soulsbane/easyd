module register;

string registerFunction(alias name)()
{
	immutable func = "funcs." ~ name ~ " = &" ~ name ~ ";";
	return func;
}
