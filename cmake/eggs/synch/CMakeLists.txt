cmake_minimum_required(VERSION 2.8)

project(synch C)

find_package(Chicken REQUIRED)
find_chicken_extension(setup-helper 1.2.0 REQUIRED)
find_chicken_extension(check-errors 1.12.1 REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 2.1.2
    DESCRIPTION "Synchronization Forms"
    CATEGORY "hell"
    LICENSE "BSD"
    AUTHOR "Kon Lovett")

add_chicken_module(synch synch.scm EXTENSION
    OPTIONS -optimize-level 3 -debug-level 1 -fixnum-arithmetic
            -disable-interrupts)

install_chicken_modules(synch)
