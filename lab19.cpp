#include <iostream>
#include <cstring>

extern "C" int String_length(char *);
char s1[] = "Cat in the hat.";

using namespace std;

int main()
{
cout << s1 << "C-string length= " << strlen(s1) << endl;
cout << s1 << "ASM length=	" << String_length(s1) << endl;

return 0;
}