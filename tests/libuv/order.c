#include <stdint.h>
#include <stdio.h>
#include <unistd.h>
#include <uv.h>

static uv_loop_t *loop;
static uv_prepare_t prepare1;
static uv_prepare_t prepare2;
static uv_check_t check1;
static uv_check_t check2;
static uv_idle_t idle1;
static uv_idle_t idle2;
static uv_idle_t idle3;
static uv_signal_t sig_int;
static uv_timer_t timer1;
static uv_timer_t timer2;

void prepare1_cb(uv_prepare_t *handle) { printf("%s\n", __func__); usleep(200000); }
void prepare2_cb(uv_prepare_t *handle) { printf("%s\n", __func__); usleep(200000); }

void check1_cb(uv_check_t *handle) { printf("%s\n", __func__); usleep(200000); }
void check2_cb(uv_check_t *handle) { printf("%s\n", __func__); usleep(200000); }

void idle1_cb(uv_idle_t *handle);
void idle2_cb(uv_idle_t *handle);
void idle3_cb(uv_idle_t *handle);

void idle1_cb(uv_idle_t *handle)
{
    printf("%s\n", __func__); usleep(200000);

    uv_idle_start(&idle2, idle2_cb);
    
    /* if (!uv_is_active((uv_handle_t*)&idle2)) */
    /*     uv_idle_start(&idle2, idle2_cb); */
    /* else */
    /*     uv_idle_stop(&idle2); */
}

void idle2_cb(uv_idle_t *handle)
{
    printf("%s\n", __func__); usleep(200000);

    uv_idle_stop(handle);
    uv_idle_start(&idle3, idle3_cb);

    /* if (!uv_is_active((uv_handle_t*)&idle3)) */
    /*     uv_idle_start(&idle3, idle3_cb); */
    /* else */
    /*     uv_idle_stop(&idle3); */
}

void idle3_cb(uv_idle_t *handle)
{
    printf("%s\n", __func__); usleep(200000);

    uv_idle_stop(handle);

    /* if (!uv_is_active((uv_handle_t*)&idle1)) */
    /*     uv_idle_start(&idle1, idle1_cb); */
    /* else */
    /*     uv_idle_stop(&idle1); */
}

void timer1_cb(uv_timer_t *handle) { printf("%s\n", __func__); }
void timer2_cb(uv_timer_t *handle)
{
    printf("%s\n", __func__);
    uv_timer_start(&timer2, timer2_cb, 1, 0);
}

void signal_cb(uv_signal_t *handle, int signum)
{
    printf("%s: %d\n", __func__, signum);

    uv_signal_stop(handle);

    uv_prepare_stop(&prepare1);
    uv_prepare_stop(&prepare2);
    uv_check_stop(&check1);
    uv_check_stop(&check2);
    uv_idle_stop(&idle1);
    uv_idle_stop(&idle2);
    uv_idle_stop(&idle3);
    uv_timer_stop(&timer1);
    uv_timer_stop(&timer2);
}

int main(int argc, char *argv[])
{
    int err = 0;
    loop = uv_default_loop();

    uv_prepare_init(loop, &prepare1);
    uv_prepare_init(loop, &prepare2);

    uv_check_init(loop, &check1);
    uv_check_init(loop, &check2);

    uv_idle_init(loop, &idle1);
    uv_idle_init(loop, &idle2);
    uv_idle_init(loop, &idle3);

    uv_timer_init(loop, &timer1);
    uv_timer_init(loop, &timer2);

    uv_signal_init(loop, &sig_int);

    uv_prepare_start(&prepare1, prepare1_cb);
    /* uv_prepare_start(&prepare2, prepare2_cb); */

    /* uv_check_start(&check1, check1_cb); */
    /* uv_check_start(&check2, check2_cb); */

    uv_idle_start(&idle1, idle1_cb);
    /* uv_idle_start(&idle2, idle2_cb); */
    /* uv_idle_start(&idle3, idle3_cb); */

    /* uv_timer_start(&timer1, timer1_cb, 0, 2); */
    /* uv_timer_start(&timer2, timer2_cb, 0, 0); */

    uv_signal_start(&sig_int, signal_cb, SIGINT);

    return uv_run(loop, UV_RUN_DEFAULT);
}
