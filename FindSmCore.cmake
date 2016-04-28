include(FindPackageHandleStandardArgs)

find_path(SMCORE_INCLUDE_DIR smcore/smcore.h)
find_library(SMCORE_LIBRARY smcore)

mark_as_advanced(SMCORE_INCLUDE_DIRS SMCORE_LIBRARIES)

set(SMCORE_INCLUDE_DIRS
    ${SMCORE_INCLUDE_DIR})
set(SMCORE_LIBRARIES
    ${SMCORE_LIBRARY})

find_package_handle_standard_args(SMCORE DEFAULT_MSG
    SMCORE_LIBRARIES SMCORE_INCLUDE_DIRS)
