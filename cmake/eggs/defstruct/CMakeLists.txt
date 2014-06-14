cmake_minimum_required(VERSION 2.8)

project(defstruct C)

find_package(Chicken REQUIRED)

define_chicken_extension(defstruct
    VERSION 1.6
    DESCRIPTION "A more convenient form of define-record"
    CATEGORY "data"
    LICENSE "BSD"
    AUTHOR "Dorai Sitaram")

set(CHICKEN_OPTIONS -optimize-level 2 -debug-level 0)

add_chicken_module(defstruct defstruct.scm EXTENSION)

install_chicken_modules(defstruct)
