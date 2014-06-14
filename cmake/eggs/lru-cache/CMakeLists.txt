cmake_minimum_required(VERSION 2.8)

project(lru-cache C)

find_package(Chicken REQUIRED)
find_chicken_extension(record-variants REQUIRED)

define_chicken_extension(lru-cache
    VERSION 0.5.3
    DESCRIPTION "LRU cache"
    CATEGORY "data"
    LICENSE "BSD"
    AUTHOR "Jim Ursetto")

set(CHICKEN_OPTIONS -optimize-level 2 -debug-level 0 -local -inline)

add_chicken_module(lru-cache lru-cache.scm EXTENSION)

install_chicken_modules(lru-cache)
