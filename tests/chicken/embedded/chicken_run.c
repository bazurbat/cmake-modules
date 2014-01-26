#include <stdio.h>
#include <chicken.h>

int main(int argc, char *argv[])
{
    printf("chicken_run\n");

    CHICKEN_run(C_toplevel);

    return 0;
}
