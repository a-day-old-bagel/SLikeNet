const std = @import("std");
const Alloc = std.mem.Allocator;
const c = @cImport({
    @cInclude("slikenet.h");
});





//--------------------------------------------------------------------------------------------------
//
// Tests
//
//--------------------------------------------------------------------------------------------------
const expect = std.testing.expect;

test { std.testing.refAllDeclsRecursive(@This()); }

extern fn JoltCTest_Basic1() u32;
test "jolt_c.basic1" {
    const ret = JoltCTest_Basic1();
    try expect(ret != 0);
}