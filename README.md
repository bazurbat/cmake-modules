cmake-modules
=============

A collection of custom CMake modules with tests.

## FindChicken.cmake

Finds Chicken compiler and defines helper macros to help build chicken scm
files and shared libraries.

Configuration variables:

* *CHICKEN_ROOT_DIR* - Where to find chicken base directory, when
cross-compiling this is "chicken host". By default /usr is used or environment
variable *CHICKEN_PREFIX* if it is set.

* *CHICKEN_TARGET_ROOT_DIR* - Where to find "chicken target" runtime library.
Useful when cross-compiling. Uses *CHICKEN_ROOT_DIR* by default.

* *CHICKEN_PROGRAM_PREFIX* - Prefix to prepend to filenames when searching for
libraries and paths, for example "mips-". Useful when cross-compiling.

Output variables:

* *CHICKEN_FOUND* - Set if Chicken compiler was found in the configured paths.

* *CHICKEN_EXECUTABLE* - The path to the 'chicken' executable.

* *CHICKEN_CSC_EXECUTABLE* - The path to the 'csc' executable.

* *CHICKEN_INCLUDE_DIRS* - The full path to the directory containing
'chicken.h'. Add this to 'include_directories' statement when compiling
mixed C/Chicken or foreign code.

* *CHICKEN_LIBRARIES* - The libraries needed for linking Chicken .c files.

Special macros:

    add_chicken_source(OUTVAR FILENAME [OPTION...]) - Generate custom commands
        for translating FILENAME to c using chicken compiler and add the
        resulting filename to OUTVAR. Rest arguments are passed to the
        invocation of 'csc'.

    add_chicken_module(NAME FILENAME [IMPORT]... ['OPTIONS' OPTION...]) -
        Generate custom commands for translating FILENAME to chicken module
        NAME. Optionally import library names can be explicitly specified after
        FILENAME. Additional options for chicken compiler can be specified
        after keyword 'OPTIONS'.

    chicken_wrap_sources(OUTVAR [SOURCE...] ['OPTIONS' OPTION...]) -
        Generate custom command for translating the specified SOURCE files to
        c and put the resulting filenames to OUTVAR. Additional options for
        chicken compiler can be specified after keyword 'OPTIONS'. This macro
        is like "for each" version of 'add_chicken_source'.
