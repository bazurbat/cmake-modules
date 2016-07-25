# - Gpgme module

find_path(GPGME_INCLUDE_DIR gpgme.h)

find_library(GPGME_GPGERROR_LIBRARY gpg-error)
find_library(GPGME_ASSUAN_LIBRARY assuan)
find_library(GPGME_LIBRARY gpgme)

set(GPGME_INCLUDE_DIRS ${GPGME_INCLUDE_DIR})
set(GPGME_LIBRARIES ${GPGME_LIBRARY} ${GPGME_ASSUAN_LIBRARY} ${GPGME_GPGERROR_LIBRARY})

mark_as_advanced(GPGME_INCLUDE_DIRS GPGME_LIBRARIES)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Gpgme DEFAULT_MSG
    GPGME_LIBRARIES GPGME_INCLUDE_DIRS)
