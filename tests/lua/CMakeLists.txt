cmake_minimum_required(VERSION 2.8)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_HOME_DIRECTORY}/cmake)

project(lua-tests)

find_package(Lua REQUIRED)

set(CMAKE_C_FLAGS "-std=gnu99 -O2")

include_directories(${LUA_INCLUDE_DIRS})

add_custom_target(copy_scripts ALL
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_SOURCE_DIR}/script1.lua
        ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS script1.lua VERBATIM)

add_executable(test1 test1.c)
target_link_libraries(test1 ${LUA_STATIC_LIBRARIES})
