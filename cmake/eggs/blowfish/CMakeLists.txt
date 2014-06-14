cmake_minimum_required(VERSION 2.8)

project(blowfish C)

find_package(Chicken REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 1.1
    CATEGORY "crypt"
    DESCRIPTION "Blowfish"
    LICENSE "LGPL"
    AUTHOR "rivo"
    URL "https://bitbucket.org/rivo/blowfish-egg")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0)

add_chicken_module(blowfish blowfish.scm EXTENSION)

install_chicken_modules(blowfish)
