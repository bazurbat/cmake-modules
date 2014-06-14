cmake_minimum_required(VERSION 2.8)

project(matchable C)

find_package(Chicken REQUIRED)

define_chicken_extension(matchable
    VERSION 3.3
    DESCRIPTION "Hygienic MATCH replacement"
    CATEGORY "lang-exts"
    LICENSE "Public Domain"
    AUTHOR "Alex Shinn")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0)

add_chicken_module(matchable matchable.scm EXTENSION)

install_chicken_modules(matchable)
