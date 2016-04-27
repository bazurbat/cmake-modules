include(FindPackageHandleStandardArgs)

find_path(SMP_INCLUDE_DIRS smplay.h
    PATH_SUFFIXES smp)
find_library(SMP_LIBRARIES smp)

mark_as_advanced(SMP_INCLUDE_DIRS SMP_LIBRARIES)

find_package_handle_standard_args(SMP DEFAULT_MSG
    SMP_LIBRARIES SMP_INCLUDE_DIRS)
