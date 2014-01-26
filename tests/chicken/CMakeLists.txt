cmake_minimum_required(VERSION 2.8)

project(tests-chicken)

find_package(Chicken REQUIRED)

set(CMAKE_C_FLAGS_RELEASE -O2)
set(CMAKE_C_FLAGS_DEBUG -O0)
set(CMAKE_C_FLAGS -std=gnu99)

set(standalone_c_SOURCES standalone.c)
add_executable(standalone_c ${standalone_c_SOURCES})

chicken_wrap_scm(standalone_scm_SOURCES standalone.scm)
add_executable(standalone_scm ${standalone_scm_SOURCES})
target_link_libraries(standalone_scm ${CHICKEN_LIBRARIES})

set(SOURCES foreign.c)
add_chicken_source(SOURCES with_foreign.scm)
add_executable(with_foreign ${SOURCES})
target_link_libraries(with_foreign ${CHICKEN_LIBRARIES})

add_subdirectory(embedded)
add_subdirectory(modules)
