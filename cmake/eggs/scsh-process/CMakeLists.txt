cmake_minimum_required(VERSION 2.8)

project(scsh-process C)

find_package(Chicken REQUIRED)

define_chicken_extension(scsh-process
    VERSION 0.4.1
    CATEGORY "os"
    LICENSE "BSD"
    AUTHOR "Peter Bex"
    URL "https://bitbucket.org/sjamaan/scsh-process")

# TODO: investigate how to implement feature check based on Chicken version

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0)

add_chicken_module(scsh-process scsh-process.scm EXTENSION)

install_chicken_modules(scsh-process)
