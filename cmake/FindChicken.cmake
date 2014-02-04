# - Find Chicken Scheme compiler
# Finds Chicken compiler and defines helper macros to help build chicken scm
# files and shared libraries.
#
# Configuration variables:
#
#   CHICKEN_ROOT_DIR - Where to find chicken base directory, when
#       cross-compiling this is "chicken host". By default /usr is used or
#       environment variable CHICKEN_PREFIX if it is set.
#   CHICKEN_TARGET_ROOT_DIR - Where to find "chicken target" runtime library.
#       Useful when cross-compiling. Uses CHICKEN_ROOT_DIR by default.
#   CHICKEN_PROGRAM_PREFIX - Prefix to prepend to filenames when searching for
#       libraries and paths, for example "mips-". Useful when cross-compiling.
#
# Output variables:
#
#   CHICKEN_FOUND - Set if Chicken compiler was found in the configured paths.
#   CHICKEN_EXECUTABLE - The path to the 'chicken' executable.
#   CHICKEN_CSC_EXECUTABLE - The path to the 'csc' executable.
#   CHICKEN_INCLUDE_DIRS - The full path to the directory containing
#       'chicken.h'. Add this to 'include_directories' statement when compiling
#       mixed C/Chicken or foreign code.
#   CHICKEN_LIBRARIES - The libraries needed for linking Chicken .c files.
#
# Special macros:
#
#   add_chicken_source(OUTVAR FILENAME [OPTION...]) - Generate custom commands
#       for translating FILENAME to c using chicken compiler and add the
#       resulting filename to OUTVAR. Rest arguments are passed to the
#       invocation of 'csc'.
#
#   add_chicken_module(NAME FILENAME [IMPORT]... ['OPTIONS' OPTION...]) -
#       Generate custom commands for translating FILENAME to chicken module
#       NAME. Optionally import library names can be explicitly specified after
#       FILENAME. Additional options for chicken compiler can be specified
#       after keyword 'OPTIONS'.
#
#   chicken_wrap_sources(OUTVAR [SOURCE...] ['OPTIONS' OPTION...]) -
#       Generate custom command for translating the specified SOURCE files to
#       c and put the resulting filenames to OUTVAR. Additional options for
#       chicken compiler can be specified after keyword 'OPTIONS'. This macro
#       is like "for each" version of 'add_chicken_source'.
#

if(NOT CHICKEN_ROOT_DIR)
    if(EXISTS $ENV{CHICKEN_PREFIX})
        set(_chicken_root $ENV{CHICKEN_PREFIX})
    else()
        set(_chicken_root "/usr")
    endif()
    set(CHICKEN_ROOT_DIR ${_chicken_root} CACHE PATH
        "Chicken host install root")
endif()

find_program(CHICKEN_EXECUTABLE ${CHICKEN_PROGRAM_PREFIX}chicken
    PATHS ${CHICKEN_ROOT_DIR}/bin
    NO_DEFAULT_PATH)
find_program(CHICKEN_CSC_EXECUTABLE ${CHICKEN_PROGRAM_PREFIX}csc
    PATHS ${CHICKEN_ROOT_DIR}/bin
    NO_DEFAULT_PATH)
find_path(CHICKEN_INCLUDE_DIR chicken.h
    PATHS ${CHICKEN_ROOT_DIR}/include/${CHICKEN_PROGRAM_PREFIX}chicken
    NO_DEFAULT_PATH)
find_library(CHICKEN_LIBRARY
    NAMES chicken ${CHICKEN_PROGRAM_PREFIX}chicken
    PATHS ${CHICKEN_TARGET_ROOT_DIR}/lib ${CHICKEN_ROOT_DIR}/lib
    NO_DEFAULT_PATH)

mark_as_advanced(CHICKEN_EXECUTABLE CHICKEN_CSC_EXECUTABLE
    CHICKEN_INCLUDE_DIR CHICKEN_LIBRARY)

function(_chicken_args_options _ARGS _OPTIONS)
    set(_doing_options FALSE)
    foreach(_arg ${ARGN})
        if("${_arg}" STREQUAL "OPTIONS")
            set(_doing_options TRUE)
        else()
            if(_doing_options)
                list(APPEND _options ${_arg})
            else()
                list(APPEND _files ${_arg})
            endif()
        endif ()
    endforeach()
    set(${_ARGS} ${_files} PARENT_SCOPE)
    set(${_OPTIONS} ${_options} PARENT_SCOPE)
endfunction()

function(_chicken_flags _OUTVAR)
    execute_process(
        COMMAND ${CHICKEN_CSC_EXECUTABLE} / -dry-run -t ${ARGN}
        COMMAND cut "-f5-" "-d "
        OUTPUT_VARIABLE _flags
        OUTPUT_STRIP_TRAILING_WHITESPACE)
    separate_arguments(_flags UNIX_COMMAND ${_flags})
    set(${_OUTVAR} ${_flags} PARENT_SCOPE)
endfunction()

function(_chicken_cflags _OUTVAR)
    execute_process(COMMAND ${CHICKEN_CSC_EXECUTABLE} -cflags ${ARGN}
        OUTPUT_VARIABLE _list
        OUTPUT_STRIP_TRAILING_WHITESPACE)
    separate_arguments(_list UNIX_COMMAND ${_list})
    #list(APPEND _list "-Wno-unused-label")
    foreach(_f ${_list})
        set(_flags "${_flags} ${_f}")
    endforeach()
    set(${_OUTVAR} ${_flags} PARENT_SCOPE)
endfunction()

function(_chicken_custom_command _OUTPUT _INPUT)
    string(REGEX REPLACE "(.*)\\.scm$" "\\1.chicken.c" _cname ${_INPUT})

    get_filename_component(_input ${_INPUT} ABSOLUTE)
    file(TO_NATIVE_PATH ${_input} _input)

    get_filename_component(_path ${_input} PATH)
    file(TO_NATIVE_PATH ${_path} _path)

    set(_output ${CMAKE_CURRENT_BINARY_DIR}/${_cname})
    file(TO_NATIVE_PATH ${_output} _output)

    _chicken_cflags(_compile_flags ${ARGN})
    set_property(SOURCE ${_output} APPEND_STRING PROPERTY
        COMPILE_FLAGS " -I${_path} ${_compile_flags}")

    _chicken_flags(_flags ${ARGN} ${CHICKEN_ARGS})
    add_custom_command(
        OUTPUT ${_output} ${_command_output}
        COMMAND ${CHICKEN_EXECUTABLE}
        ARGS ${_input} -output-file ${_output} -include-path ${_path}
             ${_flags} ${_command_args}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        DEPENDS ${_input}
        VERBATIM)

    set(${_OUTPUT} ${_output} PARENT_SCOPE)
endfunction()

function(add_chicken_source _OUTVAR _FILENAME)
    _chicken_custom_command(_output ${_FILENAME} ${ARGN})
    list(APPEND ${_OUTVAR} ${_output})
    set(${_OUTVAR} ${${_OUTVAR}} PARENT_SCOPE)
endfunction()

function(add_chicken_module _NAME _FILENAME)
    _chicken_args_options(_names _options ${ARGN})
    if(_names)
        set(_libs ${_names})
    else()
        set(_libs ${_NAME})
    endif()

    foreach(_n ${_libs})
        set(_command_output ${_command_output} ${_n}.import.scm)
        set(_command_args ${_command_args} -emit-import-library ${_n})
    endforeach()
    _chicken_custom_command(source ${_FILENAME} -s ${_options})

    add_library(${_NAME} MODULE ${source})
    set_target_properties(${_NAME} PROPERTIES PREFIX "")
    target_link_libraries(${_NAME} ${CHICKEN_LIBRARIES})
endfunction()

function(chicken_wrap_sources _SOURCES)
    _chicken_args_options(_files _options ${ARGN})
    foreach(_f ${_files})
        add_chicken_source(_sources ${_f} ${_options})
    endforeach()
    list(APPEND ${_SOURCES} ${_sources})
    set(${_SOURCES} ${${_SOURCES}} PARENT_SCOPE)
endfunction()

include(FindPackageHandleStandardArgs)
include(FindPackageMessage)

find_package_handle_standard_args(Chicken DEFAULT_MSG CHICKEN_ROOT_DIR
    CHICKEN_EXECUTABLE CHICKEN_CSC_EXECUTABLE
    CHICKEN_INCLUDE_DIR CHICKEN_LIBRARY)

if(CHICKEN_FOUND)
    set(CHICKEN_INCLUDE_DIRS ${CHICKEN_INCLUDE_DIR})
    execute_process(
        COMMAND ${CHICKEN_CSC_EXECUTABLE} -libs
        COMMAND cut "-f2-" "-d "
        OUTPUT_VARIABLE CHICKEN_LIBRARIES
        OUTPUT_STRIP_TRAILING_WHITESPACE)
    set(CHICKEN_LIBRARIES ${CHICKEN_LIBRARY} ${CHICKEN_LIBRARIES})

    find_package_message(Chicken
        "\tCHICKEN_EXECUTABLE: ${CHICKEN_EXECUTABLE}
\tCHICKEN_INCLUDE_DIR: ${CHICKEN_INCLUDE_DIR}
\tCHICKEN_LIBRARY: ${CHICKEN_LIBRARY}"
        "$CHICKEN_ROOT_DIR")
endif()
