project(embedded)

add_chicken_executable(chicken_run EMBEDDED
    SOURCES program.scm unit.scm
    C_SOURCES chicken_run.c)
