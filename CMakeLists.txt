cmake_minimum_required(VERSION 2.8)

project(cmake-modules)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_HOME_DIRECTORY}/cmake)

add_subdirectory(tests)
