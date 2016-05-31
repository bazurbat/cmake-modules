# - LibASS module

find_package(PkgConfig)
pkg_check_modules(PC_DBUS dbus-1)

find_library(DBUS_LIBRARIES
    NAMES dbus-1
    HINTS ${PC_DBUS_LIBRARY_DIRS})

find_path(DBUS_INCLUDE_DIR
    NAMES dbus/dbus.h
    HINTS ${PC_DBUS_INCLUDE_DIRS})

set(DBUS_INCLUDE_DIRS ${DBUS_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(DBus DEFAULT_MSG
    DBUS_LIBRARIES DBUS_INCLUDE_DIRS)
