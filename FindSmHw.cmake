include(FindPackageHandleStandardArgs)

find_path(SMHW_INCLUDE_DIR board_id.h
    PATH_SUFFIXES smhw)
find_library(SMHW_LIBRARY smhw)

mark_as_advanced(SMHW_INCLUDE_DIR SMHW_LIBRARY)

set(SMHW_INCLUDE_DIRS
    ${SMHW_INCLUDE_DIR}/hisi
    ${SMHW_INCLUDE_DIR})
set(SMHW_LIBRARIES
    ${SMHW_LIBRARY})

find_package_handle_standard_args(SMHW DEFAULT_MSG
    SMHW_LIBRARIES SMHW_INCLUDE_DIRS)
