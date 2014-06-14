cmake_minimum_required(VERSION 2.8)

project(bind C)

find_package(Chicken REQUIRED)
find_chicken_extension(silex)
find_chicken_extension(matchable)
find_chicken_extension(coops)
find_chicken_extension(regex)
find_chicken_extension(make)

define_chicken_extension(bind
    VERSION 1.5.2
    CATEGORY "ffi"
    DESCRIPTION "Automatically generate bindings from C/C++ declarations"
    LICENSE "public domain"
    AUTHOR "Felix Winkelmann"
    URL "http://wiki.call-cc.org/eggref/4/bind")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0 CACHE INTERNAL "")

add_custom_command(
    OUTPUT ${PROJECT_SOURCE_DIR}/c.l.scm
    COMMAND ${CSI_EXECUTABLE} -s runsilex.scm
    DEPENDS c.l
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})

add_chicken_module(cplusplus-object cplusplus-object.scm EXTENSION)
add_chicken_module(bind-translator bind-translator.scm EXTENSION
    DEPENDS ${PROJECT_SOURCE_DIR}/c.l.scm)
add_chicken_module(bind bind.scm EXTENSION
    DEPENDS bind-translator.import)
add_chicken_executable(chicken-bind chicken-bind.scm
    DEPENDS bind-translator.import)

install_chicken_modules(bind
    TARGETS chicken-bind)
