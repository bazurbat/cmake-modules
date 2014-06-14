cmake_minimum_required(VERSION 2.8)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_HOME_DIRECTORY}/cmake)

project(ffmpeg)

find_package(FFmpeg REQUIRED COMPONENTS avcodec avfilter avformat avutil
    swresample swscale)

set(CMAKE_C_FLAGS "-std=gnu99 -O3 -fomit-frame-pointer")

include_directories(${FFMPEG_INCLUDE_DIRS})

add_executable(read_frame read_frame.c)
target_link_libraries(read_frame ${FFMPEG_LIBRARIES})
