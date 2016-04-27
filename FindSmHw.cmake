include(FindPackageHandleStandardArgs)

find_path(SMHW_INCLUDE_DIRS smhw.h
    PATH_SUFFIXES smhw)
find_library(SMHW_LIBRARIES smhw)

mark_as_advanced(SMHW_INCLUDE_DIRS SMHW_LIBRARIES)

find_package_handle_standard_args(SMHW DEFAULT_MSG
    SMHW_LIBRARIES SMHW_INCLUDE_DIRS)
