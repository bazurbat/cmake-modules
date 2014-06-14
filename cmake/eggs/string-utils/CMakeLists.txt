cmake_minimum_required(VERSION 2.8)

project(string-utils C)

find_package(Chicken REQUIRED)
find_chicken_extension(setup-helper 1.5.2  REQUIRED)
find_chicken_extension(miscmacros   2.9    REQUIRED)
find_chicken_extension(lookup-table 1.13.1 REQUIRED)
find_chicken_extension(check-errors 1.12.1 REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 1.2.4
    DESCRIPTION "String Utilities"
    CATEGORY "data"
    LICENSE "BSD"
    AUTHOR "Kon Lovett")

set(CHICKEN_OPTIONS -scrutinize -fixnum-arithmetic -inline -local
    -optimize-level 3 -debug-level 0 -no-procedure-checks)

add_chicken_module(unicode-utils unicode-utils.scm EXTENSION EMIT_INLINES EMIT_TYPES)
add_chicken_module(memoized-string memoized-string.scm EXTENSION EMIT_TYPES
    OPTIONS -disable-interrupts
    DEPENDS unicode-utils.import)
add_chicken_module(to-hex to-hex.scm EXTENSION EMIT_TYPES)
add_chicken_module(string-hexadecimal string-hexadecimal.scm EXTENSION EMIT_TYPES
    DEPENDS to-hex.import)
add_chicken_module(string-utils string-utils.scm EXTENSION EMIT_TYPES
    DEPENDS memoized-string.import unicode-utils.import
            string-hexadecimal.import)

install_chicken_modules(string-utils)
