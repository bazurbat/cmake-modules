cmake_minimum_required(VERSION 2.8)

project(md5 C)

find_package(Chicken REQUIRED)
find_chicken_extension(message-digest 3.0.0 REQUIRED)

define_chicken_extension(md5
    VERSION 3.0.0
    DESCRIPTION "Computes MD5 (RFC1321) checksums"
    CATEGORY "crypt"
    LICENSE "Public Domain"
    AUTHOR "Colin Plumb, packaged for Chicken by Peter Bex")

add_chicken_module(md5 md5.scm EXTENSION)

install_chicken_modules(md5)
