# - FFmpeg module

if(NOT FFMPEG_ROOT_DIR)
    set(FFMPEG_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
endif()

find_path(FFMPEG_LIBAVCODEC_INCLUDE_DIR libavcodec/avcodec.h
    PATHS ${FFMPEG_ROOT_DIR}/include
    NO_DEFAULT_PATH)

function(_ffmpeg_find_libs)
    set(names avcodec avfilter avformat swresample swscale avutil)

    foreach(n ${names})
        string(TOUPPER ${n} LIB)
        find_library(FFMPEG_${LIB}_LIBRARY ${n}
            PATHS ${FFMPEG_ROOT_DIR}/lib
            NO_DEFAULT_PATH)
        list(APPEND libs ${FFMPEG_${LIB}_LIBRARY})
    endforeach()
    set(FFMPEG_LIBRARIES ${libs} PARENT_SCOPE)
endfunction()

_ffmpeg_find_libs()

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(FFmpeg DEFAULT_MSG
    FFMPEG_LIBAVCODEC_INCLUDE_DIR
    FFMPEG_LIBRARIES)

if(FFMPEG_FOUND)
    set(FFMPEG_INCLUDE_DIRS ${FFMPEG_LIBAVCODEC_INCLUDE_DIR})
endif()
