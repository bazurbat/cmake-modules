cmake_minimum_required(VERSION 2.8)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_HOME_DIRECTORY}/cmake)

project(libuv-tests)

find_package(Libuv REQUIRED)

set(CMAKE_C_FLAGS "-std=gnu99")

include_directories(${LIBUV_INCLUDE_DIRS})

add_executable(spawn spawn.c)
target_link_libraries(spawn ${LIBUV_LIBRARIES})

add_executable(order order.c)
target_link_libraries(order ${LIBUV_LIBRARIES})
