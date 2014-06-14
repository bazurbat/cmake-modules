cmake_minimum_required(VERSION 2.8)

project(miscmacros C)

find_package(Chicken REQUIRED)

define_chicken_extension(miscmacros
    VERSION 2.95
    DESCRIPTION "Various helper macros"
    CATEGORY "lang-exts"
    LICENSE "BSD"
    AUTHOR "Felix Winkelmann")

add_chicken_module(miscmacros miscmacros.scm EXTENSION
    OPTIONS -optimize-level 3 -debug-level 0)

install_chicken_modules(miscmacros)
