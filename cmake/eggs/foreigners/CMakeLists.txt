cmake_minimum_required(VERSION 2.8)

project(foreigners C)

find_package(Chicken REQUIRED)
find_chicken_extension(matchable REQUIRED)

define_chicken_extension(foreigners
    VERSION 1.4.1
    DESCRIPTION "Foreign helper macros for Chicken 4"
    CATEGORY "lang-exts"
    LICENSE "BSD"
    AUTHOR "Jim Ursetto")

set(CHICKEN_OPTIONS -optimize-level 2 -debug-level 0)

add_chicken_module(foreigners foreigners.scm EXTENSION
    EMIT_IMPORT_LIBRARIES foreigners renaming)

install_chicken_modules(foreigners)
