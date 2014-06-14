cmake_minimum_required(VERSION 2.8)

project(crc32 C)

find_package(Chicken REQUIRED)
find_chicken_extension(setup-helper REQUIRED)

define_chicken_extension(crc32
    VERSION 1.0.0
    CATEGORY "crypt"
    DESCRIPTION "Computes CRC checksum"
    LICENSE "BSD"
    AUTHOR "Daishi Kato, rivo")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0 -fixnum-arithmetic -local
    -no-trace -no-procedure-checks -no-bound-checks)

add_chicken_module(crc32 crc32.scm EXTENSION)

install_chicken_modules(crc32)
