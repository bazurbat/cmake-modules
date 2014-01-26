project(embedded)

set(SOURCES chicken_run.c)
chicken_wrap_scm(SOURCES program.scm unit.scm OPTIONS -e)
add_executable(chicken_run ${SOURCES})
target_include_directories(chicken_run PUBLIC ${CHICKEN_INCLUDE_DIRS})
target_link_libraries(chicken_run ${CHICKEN_LIBRARIES})
