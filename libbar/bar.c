#include <stdio.h>
#include "../libfoo/foo.h"

#define MODULE_API_EXPORTS
#include "bar.h"
 
void bar(void)
{
    foo();
    puts("BAR shared lib!");
}

