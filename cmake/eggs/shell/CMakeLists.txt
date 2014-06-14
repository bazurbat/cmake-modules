cmake_minimum_required(VERSION 2.8)

project(shell C)

find_package(Chicken REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 0.3
    DESCRIPTION "Convenient shell-command invocation"
    CATEGORY "misc"
    LICENSE "Public Domain"
    AUTHOR "Felix Winkelmann")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0 CACHE INTERNAL "")

add_chicken_module(shell shell.scm EXTENSION)

install_chicken_modules(shell)
