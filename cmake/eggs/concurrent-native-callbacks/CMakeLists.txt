cmake_minimum_required(VERSION 2.8)

project(concurrent-native-callbacks C)

find_package(Chicken REQUIRED)
find_chicken_extension(typed-records REQUIRED)
find_chicken_extension(matchable REQUIRED)
find_chicken_extension(bind REQUIRED)
find_chicken_extension(miscmacros REQUIRED)
find_chicken_extension(shell REQUIRED)

define_chicken_extension(concurrent-native-callbacks
    VERSION 0.7
    CATEGORY "hell"
    DESCRIPTION "Invoke callbacks from other native threads"
    LICENSE "BSD"
    AUTHOR "bevuta IT GmbH (Felix Winkelmann)"
    URL "git://github.com/chicken-mobile/concurrent-native-callbacks.git")

set(CHICKEN_OPTIONS -optimize-level 3 -debug-level 0 CACHE INTERNAL "")

file(COPY twiddle.c DESTINATION .)

add_chicken_module(concurrent-native-callbacks-compile-time
    cncb-compile-time-module.scm EXTENSION
    DEPENDS cncb-compile-time.scm)
add_chicken_module(concurrent-native-callbacks cncb-module.scm EXTENSION
    DEPENDS cncb.scm twiddle.c concurrent-native-callbacks-compile-time.import)

install_chicken_modules(concurrent-native-callbacks)
