# - Freetype module

include(FindPackageHandleStandardArgs)

if(FREETYPE_ROOT_DIR)
    find_library(FREETYPE_LIBRARIES freetype
        PATHS ${FREETYPE_ROOT_DIR}/lib
        ${FREETYPE_ROOT_DIR}/lib64
        ${FREETYPE_ROOT_DIR}/lib32
        NO_DEFAULT_PATH)
    find_path(FREETYPE_INCLUDE_DIR ft2build.h
        PATHS ${FREETYPE_ROOT_DIR}/include
        PATH_SUFFIXES freetype2
        NO_DEFAULT_PATH)
endif()

find_library(FREETYPE_LIBRARIES freetype)
find_path(FREETYPE_INCLUDE_DIR ft2build.h
    PATH_SUFFIXES freetype2)

string(FIND ${FREETYPE_INCLUDE_DIR} "/freetype2" _freetype2_found)
if(_freetype2_found LESS 0)
    set(FREETYPE_INCLUDE_DIRS ${FREETYPE_INCLUDE_DIR}/freetype2 ${FREETYPE_INCLUDE_DIR})
else()
    set(FREETYPE_INCLUDE_DIRS ${FREETYPE_INCLUDE_DIR})
endif()

mark_as_advanced(FREETYPE_ROOT_DIR FREETYPE_LIBRARIES
    FREETYPE_INCLUDE_DIR FREETYPE_INCLUDE_DIRS)

find_package_handle_standard_args(FREETYPE DEFAULT_MSG
    FREETYPE_LIBRARIES FREETYPE_INCLUDE_DIRS)
