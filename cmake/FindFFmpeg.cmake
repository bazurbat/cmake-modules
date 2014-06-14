# - FFmpeg module

include(FindPackageHandleStandardArgs)

set(_ffmpeg_components
    avcodec
    avdevice
    avfilter
    avformat
    avresample
    avutil
    postproc
    swresample
    swscale
)

set(FFMPEG_LIBRARIES)

function(_ffmpeg_find_component name)
    string(TOUPPER ${name} uname)
    set(include FFMPEG_${uname}_INCLUDE_DIR)
    set(lib FFMPEG_${uname}_LIBRARY)

    if(FFMPEG_ROOT_DIR)
        find_path(${include} lib${name}/version.h
            PATHS ${FFMPEG_ROOT_DIR}/include
            NO_DEFAULT_PATH)
        find_library(${lib} ${name}
            PATHS ${FFMPEG_ROOT_DIR}/lib
                ${FFMPEG_ROOT_DIR}/lib64
                ${FFMPEG_ROOT_DIR}/lib32
            NO_DEFAULT_PATH)
    endif()

    find_path(${include} lib${name}/version.h)
    find_library(${lib} ${name})

    find_package_handle_standard_args(FFmpeg_${name} DEFAULT_MSG ${lib})

    if(${include})
        # assume first found is valid for all
        set(FFMPEG_INCLUDE_DIRS ${${include}} CACHE PATH
            "FFmpeg include directory")
    endif()
    if(${lib})
        list(APPEND FFMPEG_LIBRARIES ${${lib}})
    endif()
    set(FFMPEG_LIBRARIES ${FFMPEG_LIBRARIES} PARENT_SCOPE)
endfunction()

if(FFmpeg_FIND_COMPONENTS)
    foreach(C ${FFmpeg_FIND_COMPONENTS})
        _ffmpeg_find_component(${C})
    endforeach()
else()
    foreach(C ${_ffmpeg_components})
        _ffmpeg_find_component(${C})
    endforeach()
endif()

find_package_handle_standard_args(FFmpeg DEFAULT_MSG
    FFMPEG_INCLUDE_DIRS FFMPEG_LIBRARIES)
