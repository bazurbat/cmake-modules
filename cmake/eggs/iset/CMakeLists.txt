cmake_minimum_required(VERSION 2.8)

project(iset C)

find_package(Chicken REQUIRED)

define_chicken_extension(iset
    VERSION 1.8
    DESCRIPTION "Integer sets"
    CATEGORY "data"
    LICENSE "BSD"
    AUTHOR "Alex Shinn"
    URL "http://anonymous@code.call-cc.org/svn/chicken-eggs/release/4/iset")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0 -inline)

add_chicken_module(iset iset.scm EXTENSION)

install_chicken_modules(iset)
