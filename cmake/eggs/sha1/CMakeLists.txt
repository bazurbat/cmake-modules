cmake_minimum_required(VERSION 2.8)

project(sha1 C)

find_package(Chicken REQUIRED)
find_chicken_extension(message-digest 3.0.0 REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 3.0.0
    DESCRIPTION "Computes SHA1 (FIPS-180-1) checksums"
    CATEGORY "crypt"
    LICENSE "Public Domain"
    AUTHOR "Steve Reid, packaged for Chicken by Peter Bex")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 1)

add_chicken_module(sha1 sha1.scm EXTENSION)

install_chicken_modules(sha1)
