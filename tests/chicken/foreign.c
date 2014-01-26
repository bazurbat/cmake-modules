#include <stdio.h>

int foreign_var = 123;

int foreign_function(int arg)
{
    printf("foreign_function: arg %d", arg);
    return 1;
}
