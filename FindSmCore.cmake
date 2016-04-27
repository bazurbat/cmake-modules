include(FindPackageHandleStandardArgs)

find_path(SMCORE_INCLUDE_DIRS smcore.h
    PATH_SUFFIXES smcore)
find_library(SMCORE_LIBRARIES smcore)

mark_as_advanced(SMCORE_INCLUDE_DIRS SMCORE_LIBRARIES)

find_package_handle_standard_args(SMCORE DEFAULT_MSG
    SMCORE_LIBRARIES SMCORE_INCLUDE_DIRS)
