#include <uv.h>
#include <stdint.h>
#include <stdio.h>

static uv_loop_t *loop;
static uv_process_t process_req;

void on_exit(uv_process_t *req, int64_t status, int term_signal)
{
    uv_close((uv_handle_t*)req, 0);
}

int main(int argc, char *argv[])
{
    int err = 0;
    loop = uv_default_loop();

    char *args[] = { "ls", "/", 0 };
    uv_stdio_container_t stdio[] =
    {
        { .flags = UV_IGNORE },
        { .flags = UV_INHERIT_FD, .data.fd = 1 },
        { .flags = UV_INHERIT_FD, .data.fd = 2 }
    };

    uv_process_options_t options =
    {
        .exit_cb = on_exit,
        .file = "ls",
        .args = args,
        .stdio_count = sizeof stdio / sizeof *stdio,
        .stdio = stdio
    };

    if ((err = uv_spawn(loop, &process_req, &options)))
    {
        fprintf(stderr, "%s\n", uv_strerror(err));
        return 1;
    }

    return uv_run(loop, UV_RUN_DEFAULT);
}
