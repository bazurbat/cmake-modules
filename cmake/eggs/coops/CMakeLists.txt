cmake_minimum_required(VERSION 2.8)

project(coops C)

find_package(Chicken REQUIRED)
find_chicken_extension(matchable REQUIRED)
find_chicken_extension(record-variants REQUIRED)

define_chicken_extension(coops
    VERSION 1.93
    CATEGORY "oop"
    DESCRIPTION "A featureful object system"
    LICENSE "BSD"
    AUTHOR "Dorai Sitaram and Felix Winkelmann")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0 CACHE INTERNAL "")

add_chicken_module(coops coops-module.scm EXTENSION)
add_chicken_module(coops-primitive-objects coops-primitive-objects.scm EXTENSION
    DEPENDS coops.import)

install_chicken_modules(coops)
