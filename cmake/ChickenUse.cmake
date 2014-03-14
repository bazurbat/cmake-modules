# - Chicken Use Module

include(CMakeParseArguments)

macro(_chicken_parse_arguments)
    cmake_parse_arguments(compile
        "STATIC;SHARED;MODULE;EMBEDDED"
        "CHICKEN_LIBRARY"
        "EMIT;ARGS;C_FLAGS"
        ${ARGN})
endmacro()

macro(_chicken_process_arguments)
    if(compile_STATIC)
        list(APPEND command_args -feature chicken-compile-static)
        set(output_suffix ".static")
    endif()
    if(compile_SHARED)
        list(APPEND command_args -feature chicken-compile-shared)
        set(command_c_flags "${command_c_flags} -DPIC -DC_SHARED")
    endif()
    if(compile_EMBEDDED)
        set(command_c_flags "${command_c_flags} -DC_EMBEDDED")
        set(output_suffix ".embedded")
    endif()
    if(compile_SHARED AND NOT compile_EMBEDDED)
        list(APPEND command_args -dynamic)
    endif()

    foreach(emit ${compile_EMIT})
        list(APPEND command_output ${emit}.import.scm)
        list(APPEND command_args -emit-import-library ${emit})
    endforeach()

    list(APPEND command_args ${compile_ARGS})
    set(command_c_flags "${command_c_flags} ${compile_C_FLAGS}")
endmacro()

function(_chicken_command out_var in_filename)
    string(REGEX REPLACE
        "(.*)\\.scm$" "\\1${output_suffix}.chicken.c"
        out_filename ${in_filename})

    get_filename_component(out_name ${out_filename} NAME)
    if(NOT IS_ABSOLUTE ${out_filename})
        set(out_filename ${CMAKE_CURRENT_BINARY_DIR}/${out_name})
    endif()
    file(TO_CMAKE_PATH ${out_filename} out_filename)

    get_filename_component(in_filename ${in_filename} ABSOLUTE)
    file(TO_CMAKE_PATH ${in_filename} in_filename)
    get_filename_component(in_path ${in_filename} PATH)

    set_property(SOURCE ${out_filename} APPEND_STRING PROPERTY
        COMPILE_FLAGS " -I\"${CHICKEN_INCLUDE_DIR}\" -I\"${in_path}\" ${CHICKEN_C_FLAGS} ${command_c_flags}")

    add_custom_command(
        OUTPUT ${out_filename} ${command_output}
        COMMAND ${CHICKEN_EXECUTABLE}
        ARGS ${in_filename} -output-file ${out_filename} -include-path ${in_path}
             ${CHICKEN_ARGS} ${command_args}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        DEPENDS ${in_filename}
        VERBATIM)

    set(${out_var} ${out_filename} PARENT_SCOPE)
endfunction()

function(add_chicken_sources out_var)
    _chicken_parse_arguments(${ARGN})
    _chicken_process_arguments()
    foreach(arg ${compile_UNPARSED_ARGUMENTS})
        _chicken_command(output ${arg})
        list(APPEND ${out_var} ${output})
    endforeach()
    set(${out_var} ${${out_var}} PARENT_SCOPE)
endfunction()

function(add_chicken_library name)
    _chicken_parse_arguments(${ARGN})
    if(compile_STATIC)
        set(library_type STATIC)
    elseif(compile_SHARED)
        set(library_type SHARED)
    else()
        set(library_type MODULE)
        set(compile_SHARED TRUE)
    endif()
    _chicken_process_arguments()
    set(sources)
    foreach(arg ${compile_UNPARSED_ARGUMENTS})
        _chicken_command(output ${arg})
        list(APPEND sources ${output})
    endforeach()
    add_library(${name} ${library_type} ${sources})
    if(compile_CHICKEN_LIBRARY)
        target_link_libraries(${name} ${compile_CHICKEN_LIBRARY} ${CHICKEN_EXTRA_LIBRARIES})
    else()
        target_link_libraries(${name} ${CHICKEN_LIBRARIES})
    endif()
    set_target_properties(${name} PROPERTIES PREFIX "")
endfunction()
