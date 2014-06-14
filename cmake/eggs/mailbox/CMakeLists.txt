cmake_minimum_required(VERSION 2.8)

project(mailbox C)

find_package(Chicken REQUIRED)
find_chicken_extension(setup-helper    1.5.2  REQUIRED)
find_chicken_extension(check-errors    1.12.5 REQUIRED)
find_chicken_extension(condition-utils 1.0.0  REQUIRED)
find_chicken_extension(record-variants 0.5    REQUIRED)

define_chicken_extension(mailbox
    VERSION 2.1.5
    DESCRIPTION "Thread-safe queues with timeout"
    CATEGORY "hell"
    LICENSE "BSD"
    AUTHOR "Felix Winkelmann" "Kon Lovett")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0 -no-procedure-checks
    -no-bound-checks -no-argc-checks -feature unsafe-operations)

add_chicken_module(mailbox mailbox.scm EXTENSION)

install_chicken_modules(mailbox)
