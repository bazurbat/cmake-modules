#ifndef SMCORE_COUNTER_H
#define SMCORE_COUNTER_H

#include <stdio.h>
#include <sys/time.h>
#include <time.h>

#define SM_COUNTER_DATA_DIR "/tmp/"

#define SM_DEBUG_COUNTERS 1
#if SM_DEBUG_COUNTERS == 1

static inline long sm_get_time_msec()
{
    struct timespec ts = {0};
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
}

#define SM_COUNTER_DECLARE(c) \
    FILE *__sm_counter_##c##_file = 0; \
    long __sm_counter_##c = 0, \
         __sm_counter_##c##_begin = 0, \
         __sm_counter_##c##_total = 0

#define SM_COUNTER_BEGIN(c) { \
    extern FILE *__sm_counter_##c##_file; \
    extern long __sm_counter_##c##_begin; \
    __sm_counter_##c##_begin = sm_get_time_msec(); \
    if (!__sm_counter_##c##_file) \
        __sm_counter_##c##_file = fopen( \
            SM_COUNTER_DATA_DIR #c ".data", "w"); }

#define SM_COUNTER_END(c) { \
    extern FILE *__sm_counter_##c##_file; \
    extern long __sm_counter_##c, \
                __sm_counter_##c##_begin, \
                __sm_counter_##c##_total; \
    long diff = sm_get_time_msec() - __sm_counter_##c##_begin; \
    __sm_counter_##c##_total += diff; \
    if (__sm_counter_##c##_file) { \
        fprintf(__sm_counter_##c##_file, "%ld %ld\n", \
                __sm_counter_##c, diff); } \
    __sm_counter_##c++; }

#define SM_COUNTER_INC(c) { \
    extern long __sm_counter_##c; \
    if (__sm_counter_##c) { SM_COUNTER_END(c); } \
    else __sm_counter_##c++; SM_COUNTER_BEGIN(c); }

#define SM_COUNTER_CLOSE(c) { \
    extern FILE * __sm_counter_##c##_file; \
    extern long __sm_counter_##c, __sm_counter_##c##_total; \
    double avg = (double)__sm_counter_##c##_total / (double)__sm_counter_##c; \
    if (__sm_counter_##c##_file) { \
        fclose(__sm_counter_##c##_file); __sm_counter_##c##_file = 0; } \
    printf("%s: counter %s total %ld (%ld) avg %.3f\n", \
             __func__, #c, __sm_counter_##c##_total, __sm_counter_##c, avg); }

#else

#define SM_COUNTER_DECLARE(c) ;
#define SM_COUNTER_BEGIN(c) ;
#define SM_COUNTER_END(c) ;
#define SM_COUNTER_INC(c) ;
#define SM_COUNTER_CLOSE(c) ;

#endif

#endif
