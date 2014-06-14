cmake_minimum_required(VERSION 2.8)

project(feature-test C)

find_package(Chicken REQUIRED)

define_chicken_extension(feature-test
    VERSION 0.1
    DESCRIPTION "Foreign feature testing"
    CATEGORY "lang-exts"
    LICENSE "BSD"
    AUTHOR "Jim Ursetto")

set(CHICKEN_OPTIONS -optimize-level 2 -debug-level 0)

add_chicken_module(feature-test feature-test.scm EXTENSION)

install_chicken_modules(feature-test
    FILES feature-test-syntax.scm)
