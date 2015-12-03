# - LibASS module

find_package(PkgConfig)
pkg_check_modules(LIBASS libass)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibASS DEFAULT_MSG
    LIBASS_LIBRARIES LIBASS_INCLUDE_DIRS)
