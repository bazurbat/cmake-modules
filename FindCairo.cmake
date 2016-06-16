# - Freetype module

include(FindPackageHandleStandardArgs)

if(CAIRO_ROOT_DIR)
    find_library(CAIRO_LIBRARIES cairo
        PATHS ${CAIRO_ROOT_DIR}/lib
        ${CAIRO_ROOT_DIR}/lib64
        ${CAIRO_ROOT_DIR}/lib32
        NO_DEFAULT_PATH)
    find_path(CAIRO_INCLUDE_DIR ft2build.h
        PATHS ${CAIRO_ROOT_DIR}/include
        PATH_SUFFIXES cairo
        NO_DEFAULT_PATH)
endif()

find_library(CAIRO_LIBRARIES cairo)
find_library(PIXMAN_LIBRARIES pixman-1)
find_path(CAIRO_INCLUDE_DIR cairo.h
    PATH_SUFFIXES cairo)

string(FIND ${CAIRO_INCLUDE_DIR} "/cairo" _cairo_found)
if(_cairo_found LESS 0)
    set(CAIRO_INCLUDE_DIRS ${CAIRO_INCLUDE_DIR}/cairo ${CAIRO_INCLUDE_DIR})
else()
    set(CAIRO_INCLUDE_DIRS ${CAIRO_INCLUDE_DIR})
endif()

mark_as_advanced(CAIRO_ROOT_DIR CAIRO_LIBRARIES
    CAIRO_INCLUDE_DIR CAIRO_INCLUDE_DIRS)

find_package_handle_standard_args(CAIRO DEFAULT_MSG
    CAIRO_LIBRARIES CAIRO_INCLUDE_DIRS)
