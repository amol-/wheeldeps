#include <stdio.h>
#include "../libfoo/foo.h"
 
void bar(void)
{
    foo();
    puts("BAR shared lib!");
}

