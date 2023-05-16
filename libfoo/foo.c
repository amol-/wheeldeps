#include <stdio.h>

#define MODULE_API_EXPORTS
#include "foo.h" 
 
void foo(void)
{
    puts("FOO shared lib!");
}

