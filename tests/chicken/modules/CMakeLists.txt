project(chicken-modules)

set(CHICKEN_EMIT_TYPES YES)
set(CHICKEN_EMIT_INLINES NO)
set(CHICKEN_OPTIONS -scrutinize)

add_chicken_module(module module.scm EMIT_TYPES)
add_chicken_module(mmodule1 mmodule.scm SUFFIX 1 EMIT_IMPORT_LIBRARIES module1)
add_chicken_module(mmodule2 mmodule.scm SUFFIX 2 EMIT module2)

add_chicken_executable(usemodule usemodule.scm
    DEPENDS module.import module1.import module2.import)

add_chicken_library(module-static module.scm STATIC)

add_chicken_executable(usestaticmodule usestaticmodule.scm STATIC)
target_link_libraries(usestaticmodule module-static)
