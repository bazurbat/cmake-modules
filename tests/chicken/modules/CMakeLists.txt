project(chicken-modules)

set(SOURCES)
add_chicken_source(SOURCES usemodule.scm -O1 -include-path "spa ced")
add_chicken_module(module module.scm OPTIONS -O2 -inline)
add_chicken_module(mmodule mmodule.scm module1 module2 OPTIONS -O3 -profile)
add_executable(usemodule ${SOURCES})
add_dependencies(usemodule module mmodule)
target_link_libraries(usemodule ${CHICKEN_LIBRARIES})
