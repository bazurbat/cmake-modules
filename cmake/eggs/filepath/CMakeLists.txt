cmake_minimum_required(VERSION 2.8)

project(filepath C)

find_package(Chicken REQUIRED)
find_chicken_extension(matchable REQUIRED)

define_chicken_extension(filepath
    VERSION 1.5
    DESCRIPTION "Cross-platform file path manipulation"
    CATEGORY "parsing"
    LICENSE "BSD"
    AUTHOR "Ivan Raikov")

set(CHICKEN_OPTIONS -optimize-level 2 -debug-level 0)

add_chicken_module(filepath filepath.scm EXTENSION)

install_chicken_modules(filepath)
