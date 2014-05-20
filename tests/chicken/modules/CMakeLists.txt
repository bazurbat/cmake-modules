project(chicken-modules)

add_chicken_module(module module.scm EMIT module OPTIONS -optimize-level 2 -inline)
add_chicken_module(mmodule mmodule.scm EMIT module1 module2
    OPTIONS -optimize-level 3 -profile C_FLAGS -O0 -O2)

set(SOURCES)
add_chicken_sources(SOURCES usemodule.scm
    OPTIONS -optimize-level 0 -include-path "spa ced")
add_executable(usemodule ${SOURCES})
add_dependencies(usemodule module mmodule)
target_link_libraries(usemodule ${CHICKEN_LIBRARIES})
