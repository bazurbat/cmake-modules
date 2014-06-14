cmake_minimum_required(VERSION 2.8)

project(variable-item C)

find_package(Chicken REQUIRED)
find_chicken_extension(setup-helper 1.2.0  REQUIRED)
find_chicken_extension(check-errors 1.12.1 REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 1.3.0
    CATEGORY "misc"
    LICENSE "BSD"
    AUTHOR "Kon Lovett")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 1 -no-procedure-checks
    -fixnum-arithmetic)

add_chicken_module(variable-item variable-item.scm EXTENSION)

install_chicken_modules(variable-item)
