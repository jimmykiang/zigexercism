// An Armstrong number is a number that is the sum of its own digits each raised to the power of the number of digits.
//
// For example:
//
// 9 is an Armstrong number, because 9 = 9^1 = 9
// 10 is not an Armstrong number, because 10 != 1^2 + 0^2 = 1
// 153 is an Armstrong number, because: 153 = 1^3 + 5^3 + 3^3 = 1 + 125 + 27 = 153
// 154 is not an Armstrong number, because: 154 != 1^3 + 5^3 + 4^3 = 1 + 125 + 64 = 190
// Write some code to determine whether a number is an Armstrong number.

pub fn isArmstrongNumber(num: u128) bool {
    var number: u128 = num;

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const ArrayList = std.ArrayList;
    var list = ArrayList(u128).init(allocator);
    defer list.deinit();

    var tmp: u128 = 0;

    while (number > 0) {
        tmp = number % 10;
        number /= 10;

        list.append(tmp) catch |err| {
            std.debug.print("Append error: {}", .{err});
            return false;
        };
    }

    // std.debug.print("i: {}", .{list.items.len});

    var result: u128 = 0;
    for (list.items) |i| {
        result += std.math.pow(comptime u128, i, list.items.len);
    }
    return num == result;
}

const math = @import("std").math;
const std = @import("std");
const testing = std.testing;
test "zero is an armstrong number" {
    try testing.expect(isArmstrongNumber(0));
}
test "single-digit numbers are armstrong numbers" {
    try testing.expect(isArmstrongNumber(5));
}
test "there are no two-digit armstrong numbers" {
    try testing.expect(!isArmstrongNumber(10));
}
test "three-digit number that is an armstrong number" {
    try testing.expect(isArmstrongNumber(153));
}
test "three-digit number that is not an armstrong number" {
    try testing.expect(!isArmstrongNumber(100));
}
test "four-digit number that is an armstrong number" {
    try testing.expect(isArmstrongNumber(9_474));
}
test "four-digit number that is not an armstrong number" {
    try testing.expect(!isArmstrongNumber(9_475));
}
test "seven-digit number that is an armstrong number" {
    try testing.expect(isArmstrongNumber(9_926_315));
}
test "seven-digit number that is not an armstrong number" {
    try testing.expect(!isArmstrongNumber(9_926_314));
}
test "33-digit number that is an armstrong number" {
    try testing.expect(isArmstrongNumber(186_709_961_001_538_790_100_634_132_976_990));
}
test "38-digit number that is not an armstrong number" {
    try testing.expect(!isArmstrongNumber(99_999_999_999_999_999_999_999_999_999_999_999_999));
}
test "the largest and last armstrong number" {
    try testing.expect(isArmstrongNumber(115_132_219_018_763_992_565_095_597_973_971_522_401));
}
test "the largest 128-bit unsigned integer value is not an armstrong number" {
    try testing.expect(!isArmstrongNumber(340_282_366_920_938_463_463_374_607_431_768_211_455));
}
