# - Libuv module

find_path(LIBUV_INCLUDE_DIRS uv.h
    PATHS ${LIBUV_ROOT_DIR}/include
    NO_DEFAULT_PATH)
find_library(LIBUV_LIBRARIES uv
    PATHS ${LIBUV_ROOT_DIR}/lib
    NO_DEFAULT_PATH)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(Libuv DEFAULT_MSG
    LIBUV_INCLUDE_DIRS LIBUV_LIBRARIES)
