cmake_minimum_required(VERSION 2.8)

project(silex C)

find_package(Chicken REQUIRED)

define_chicken_extension(${PROJECT_NAME}
    VERSION 1.4
    DESCRIPTION "An efficient and powerful lexer generator"
    CATEGORY "parsing"
    LICENSE "BSD"
    AUTHOR "Danny Dub&eacute;")

add_chicken_module(silex silex.scm EXTENSION
    OPTIONS -optimize-level 2 -debug-level 1)

install_chicken_modules(silex)
