cmake_minimum_required(VERSION 2.8)

project(make C)

find_package(Chicken REQUIRED)

define_chicken_extension(make
    VERSION 1.7
    DESCRIPTION "The PLT 'make' macro"
    CATEGORY "lang-exts"
    LICENSE "LGPL-1"
    AUTHOR "PLT, adapted to Chicken by Felix Winkelmann")

add_chicken_module(make make.scm EXTENSION
    OPTIONS -optimize-level 2 -debug-level 1)

install_chicken_modules(make)
