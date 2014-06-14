cmake_minimum_required(VERSION 2.8)

project(utf8 C)

find_package(Chicken REQUIRED)
find_chicken_extension(iset REQUIRED)
find_chicken_extension(regex REQUIRED)
find_chicken_extension(make REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 3.3.9
    DESCRIPTION "Unicode support"
    CATEGORY "parsing"
    LICENSE "BSD"
    AUTHOR "Alex Shinn")

set(CHICKEN_OPTIONS -fixnum-arithmetic -inline -local -optimize-level 3
    -debug-level 0)

add_chicken_module(utf8-lolevel utf8-lolevel.scm EXTENSION)
add_chicken_module(utf8 utf8.scm EXTENSION
    DEPENDS utf8-lolevel.import)
add_chicken_module(utf8-srfi-14 utf8-srfi-14.scm EXTENSION
    DEPENDS utf8-lolevel.import)
add_chicken_module(unicode-char-sets unicode-char-sets.scm EXTENSION)
add_chicken_module(utf8-case-map utf8-case-map.scm EXTENSION
    DEPENDS utf8-lolevel.import utf8-srfi-14.import)
add_chicken_module(utf8-srfi-13 utf8-srfi-13.scm EXTENSION
    DEPENDS utf8-lolevel.import utf8-srfi-14.import utf8-case-map.import)

install_chicken_modules(utf8
    FILES case-map-1.dat case-map-2.dat)
