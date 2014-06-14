cmake_minimum_required(VERSION 2.8)

project(blob-utils C)

find_package(Chicken REQUIRED)
find_chicken_extension(setup-helper 1.5.2 REQUIRED)
find_chicken_extension(string-utils 1.2.2 REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 1.0.3
    DESCRIPTION "Blob Utilities"
    CATEGORY "data"
    LICENSE "BSD"
    AUTHOR "Kon Lovett")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0 -no-procedure-checks
    -no-argc-checks -no-bound-checks)

add_chicken_module(blob-set-int blob-set-int.scm EXTENSION)

add_chicken_module(blob-hexadecimal blob-hexadecimal.scm EXTENSION)

install_chicken_modules(blob-utils)
