# - Lua find module

include(FindPackageHandleStandardArgs)
include(FindPkgConfig)

if(LUA_WITH_JIT)
    pkg_check_modules(LUA REQUIRED luajit)
else()
    pkg_check_modules(LUA REQUIRED lua)
endif()

if(LUA_WITH_JIT)
    find_library(LUA_STATIC_LIBRARY libluajit-5.1.a)
else()
    find_library(LUA_STATIC_LIBRARY liblua.a)
endif()

set(LUA_STATIC_LIBRARIES ${LUA_LIBRARIES} m dl)
