cmake_minimum_required(VERSION 2.8)

project(setup-helper C)

find_package(Chicken REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 1.5.3
    DESCRIPTION "Installation/Setup Shortcut Routines"
    CATEGORY "misc"
    LICENSE "BSD"
    AUTHOR "Kon Lovett")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0)

add_chicken_module(setup-helper-mod setup-helper-mod.scm EXTENSION)

install_chicken_modules(setup-helper
    FILES setup-helper.scm)
