
local ffi = require("ffi")
ffi.cdef[[
int printf(const char *fmt, ...);
int func1(int v);
]]
ffi.C.printf("Hello %s!", "world asd")

local r = ffi.C.func1(3)
io.write(r)
io.write('\n')
