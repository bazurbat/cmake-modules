cmake_minimum_required(VERSION 2.8)

project(type-stubs C)

find_package(Chicken REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 0.0.1
    DESCRIPTION "Type syntax stubs for Chicken < 4.7.5"
    CATEGORY "lang-exts"
    LICENSE "BSD"
    AUTHOR "Moritz Heidkamp"
    URL "git@bitbucket.org:DerGuteMoritz/type-stubs.git")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0 CACHE INTERNAL "")

add_chicken_module(type-stubs type-stubs.scm EXTENSION)

install_chicken_modules(type-stubs)
