cmake_minimum_required(VERSION 2.8)

project(easyffi C)

find_package(Chicken REQUIRED)
find_chicken_extension(silex REQUIRED)
find_chicken_extension(matchable REQUIRED)
find_chicken_extension(regex REQUIRED)
find_chicken_extension(make REQUIRED)

define_chicken_extension(easyffi
    VERSION 1.99.7
    DESCRIPTION "Generates bindings from C/C++ declarations"
    CATEGORY "obsolete"
    LICENSE "BSD"
    AUTHOR "Felix Winkelmann")

set(CHICKEN_OPTIONS -optimize-level 2 -debug-level 0)

add_custom_command(
    OUTPUT ${PROJECT_SOURCE_DIR}/easyffi.l.scm
    COMMAND ${CSI_EXECUTABLE} -s runsilex.scm
    DEPENDS easyffi.l
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})
add_chicken_executable(chicken-wrap chicken-wrap.scm
    DEPENDS easyffi-base)
add_chicken_module(easyffi-base easyffi-base.scm EXTENSION
    DEPENDS easyffi.l.scm)
add_chicken_module(easyffi easyffi.scm EXTENSION
    DEPENDS easyffi-base.import)

install_chicken_modules(easyffi
    PROGRAMS chicken-wrap)
