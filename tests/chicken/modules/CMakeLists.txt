project(chicken-modules)

set(CHICKEN_EXTRACT_DEPENDS YES)

add_chicken_module(module module.scm)
add_chicken_module(mmodule1 mmodule.scm SUFFIX 1 EMIT_IMPORTS module1)
add_chicken_module(mmodule2 mmodule.scm SUFFIX 2 EMIT_IMPORTS module2)

# add_chicken_executable(usemodule usemodule.scm
#     DEPENDS module mmodule1 mmodule2)
add_chicken_executable(usemodule usemodule.scm)

# add_chicken_library(module-static module.scm STATIC
#     SUFFIX ".static")

# add_chicken_executable(usestaticmodule usestaticmodule.scm STATIC)
# target_link_libraries(usestaticmodule module-static)
