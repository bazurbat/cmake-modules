cmake_minimum_required(VERSION 2.8)

project(dbus C)

find_package(PkgConfig)
pkg_check_modules(DBUS REQUIRED dbus-1)

find_package(Chicken REQUIRED)
find_chicken_extension(easyffi REQUIRED)
find_chicken_extension(matchable REQUIRED)
find_chicken_extension(miscmacros REQUIRED)
find_chicken_extension(foreigners REQUIRED)

define_chicken_extension(dbus
    VERSION 0.93
    CATEGORY "os"
    DESCRIPTION "A binding for libdbus, the IPC mechanism"
    LICENSE "MIT"
    AUTHOR "Shawn Rutledge")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0)

include_directories(${DBUS_INCLUDE_DIRS})

add_chicken_module(dbus dbus.scm EXTENSION)
target_link_libraries(dbus ${DBUS_LIBRARIES})

install_chicken_modules(dbus)
