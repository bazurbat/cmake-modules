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
        hi_common
        hi_msp)
endif()

find_package_handle_standard_args(HiSilicon DEFAULT_MSG
    HISILICON_SDK_DIR)

if(HISILICON_FOUND)
    set(HISILICON_INCLUDE_DIRS ${HISILICON_SDK_DIR}/pub/include)
    if(ANDROID)
        set(HISILICON_LIBRARIES "")
    else()
        set(HISILICON_LIBRARIES m rt pthread ${CMAKE_DL_LIBS})
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
                      ${HISILICON_SDK_DIR}/pub/lib/static)
        endif()
        if(${_var})
            list(APPEND HISILICON_LIBRARIES ${${_var}})
        endif()
    endforeach()
endif()
