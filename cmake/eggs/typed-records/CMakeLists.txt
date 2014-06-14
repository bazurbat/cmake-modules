cmake_minimum_required(VERSION 2.8)

project(typed-records C)

find_package(Chicken REQUIRED)
find_chicken_extension(defstruct REQUIRED)
find_chicken_extension(type-stubs REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 0.6
    DESCRIPTION "Typed variants of various record-definition macros"
    CATEGORY "misc"
    LICENSE "BSD"
    AUTHOR "Felix Winkelmann")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0 CACHE INTERNAL "")

add_chicken_module(typed-records typed-records.scm EXTENSION)

install_chicken_modules(typed-records)
