# - HiSilicon module

include(FindPackageHandleStandardArgs)

find_path(HISILICON_SDK_DIR Android.def
    PATHS ${HISILICON_ROOT_DIR}
    NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)

# NOTE: contains static libraries - order matters
if(ANDROID)
    set(_hi_libraries
        c m z log
        cutils
        jpeg
        png
        freetype
        hi_common
        hi_msp
        higo
        higoadp
        hi_png
        higo_jpeg)
else()
    set(_hi_libraries
        hi_msp
        hi_mce
        hi_common)
endif()

# In order for higo libraries to 'HI_GO_Init' call to succeed
# we must link to HiSDK libraries statically
# Save previous library suffix value
set(CMAKE_FIND_LIBRARY_SUFFIXES_OLD ${CMAKE_FIND_LIBRARY_SUFFIXES})
set(CMAKE_FIND_LIBRARY_SUFFIXES .a)

find_package_handle_standard_args(HiSilicon DEFAULT_MSG
    HISILICON_SDK_DIR)

if(NOT HISILICON_FOUND)
    set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_FIND_LIBRARY_SUFFIXES_OLD})
    return()
endif()

set(HISILICON_INCLUDE_DIRS ${HISILICON_SDK_DIR}/pub/include)
set(HISILICON_MSP_INCLUDE_DIRS ${HISILICON_SDK_DIR}/source/msp/include)
set(HISILICON_MSP_API_INCLUDE_DIRS ${HISILICON_SDK_DIR}/source/msp/api/include)
set(HISILICON_MSP_DRV_INCLUDE_DIRS ${HISILICON_SDK_DIR}/source/msp/drv/include)

if(ANDROID)
    set(HISILICON_LIBRARIES "")
else()
    set(HISILICON_LIBRARIES m rt pthread ${CMAKE_DL_LIBS})
endif()

list(FIND HiSilicon_FIND_COMPONENTS HiGo HiGo_REQUIRED)
if(HiGo_REQUIRED GREATER -1)
    list(APPEND _hi_libraries png higo higoadp jpeg hi_tde hi_jpegenc)
endif()

foreach(name ${_hi_libraries})
    set(_var _HISILICON_LIBRARY_${name})
    if(ANDROID)
        find_library(${_var} ${name}
            PATHS ${HISILICON_OBJ_DIR}/SHARED_LIBRARIES/lib${name}_intermediates/LINKED
            ${HISILICON_OBJ_DIR}/STATIC_LIBRARIES/lib${name}_intermediates
            NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
    else()
        find_library(${_var} ${name}
            PATHS ${HISILICON_SDK_DIR}/pub/lib/share
                  ${HISILICON_SDK_DIR}/pub/lib/static
            NO_DEFAULT_PATH)
    endif()
    if(${_var})
        list(APPEND HISILICON_LIBRARIES ${${_var}})
    endif()
    # message(STATUS "  ${name} => ${${_var}}")
endforeach()

set(CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_FIND_LIBRARY_SUFFIXES_OLD})

unset(_hi_libraries)
