cmake_minimum_required(VERSION 2.8)

project(lookup-table C)

find_package(Chicken REQUIRED)
find_chicken_extension(setup-helper 1.5.2 REQUIRED)
find_chicken_extension(check-errors 1.10.0 REQUIRED)
find_chicken_extension(miscmacros 2.91 REQUIRED)
find_chicken_extension(record-variants 0.5 REQUIRED)
find_chicken_extension(synch 2.1.0 REQUIRED)

define_chicken_extension(lookup-table
    VERSION 1.13.5
    DESCRIPTION "Simple Lookup Table"
    CATEGORY "data"
    LICENSE "BSD"
    AUTHOR "Kon Lovett")

# MAGIC-LIMIT - Element count when hash-table faster (YMMV)
set(CHICKEN_OPTIONS
    -scrutinize
    -prelude "(define-constant MAGIC-LIMIT 12)"
    -disable-interrupts
    -fixnum-arithmetic
    -local
    -inline-limit 50
    -no-procedure-checks
    -optimize-level 3)

add_chicken_module(lookup-table lookup-table.scm EXTENSION EMIT_TYPES
    OPTIONS -debug-level 1)
add_chicken_module(lookup-table-unsafe lookup-table-unsafe.scm EXTENSION EMIT_TYPES
    OPTIONS -debug-level 0 -feature unsafe -no-bound-checks -no-argc-checks)
add_chicken_module(lookup-table-synch lookup-table-synch.scm EXTENSION EMIT_TYPES
    OPTIONS -debug-level 1
    DEPENDS lookup-table.import)
add_chicken_module(lookup-table-unsafe-synch lookup-table-unsafe-synch.scm EXTENSION EMIT_TYPES
    OPTIONS -debug-level 0 -feature unsafe -no-bound-checks -no-argc-checks
    DEPENDS lookup-table-unsafe.import)

install_chicken_modules(lookup-table)
