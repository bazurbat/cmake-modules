cmake_minimum_required(VERSION 2.8)

project(bitstring C)

find_package(Chicken REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 1.11
    CATEGORY "parsing"
    DESCRIPTION "Binary pattern matching"
    LICENSE "BSD"
    AUTHOR "rivo"
    URL "https://bitbucket.org/rivo/bitstring")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0)

add_chicken_module(bitstring bitstring.scm EXTENSION)

install_chicken_modules(bitstring)
