cmake_minimum_required(VERSION 2.8)

project(format C)

find_package(Chicken REQUIRED)

define_chicken_extension(format
    VERSION 3.1.6
    DESCRIPTION "Common-Lisp style formatted output"
    CATEGORY "io"
    LICENSE "Public Domain"
    AUTHOR "Dirk Lutzebeck"
    MAINTAINER "Felix Winkelmann" "Kon Lovett")

set(CHICKEN_OPTIONS -optimize-level 2 -debug-level 0)

add_chicken_module(format format.scm EXTENSION)

install_chicken_modules(format)
