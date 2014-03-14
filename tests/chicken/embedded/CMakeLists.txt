project(embedded)

set(SOURCES chicken_run.c)
add_chicken_sources(SOURCES program.scm unit.scm EMBEDDED)
add_executable(chicken_run ${SOURCES})
target_include_directories(chicken_run PUBLIC ${CHICKEN_INCLUDE_DIRS})
target_link_libraries(chicken_run ${CHICKEN_LIBRARIES})
