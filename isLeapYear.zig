// Introduction
// A leap year (in the Gregorian calendar) occurs:
//
// In every year that is evenly divisible by 4.
// Unless the year is evenly divisible by 100, in which case it's only a leap year if the year is also evenly divisible by 400.
// Some examples:
//
// 1997 was not a leap year as it's not divisible by 4.
// 1900 was not a leap year as it's not divisible by 400.
// 2000 was a leap year!


pub fn isLeapYear(year: u32) bool {
    if (year % 100 == 0) {
        if (year % 400 == 0) {
            return true;
        } else {
            return false;
        }
    } else if (year % 4 == 0)
        return true;
    return false;
}

const std = @import("std");
const testing = std.testing;
test "year not divisible by 4 in common year" {
    try testing.expect(!isLeapYear(2015));
}
test "year divisible by 2, not divisible by 4 in common year" {
    try testing.expect(!isLeapYear(1970));
}
test "year divisible by 4, not divisible by 100 in leap year" {
    try testing.expect(isLeapYear(1996));
}
test "year divisible by 4 and 5 is still a leap year" {
    try testing.expect(isLeapYear(1960));
}
test "year divisible by 100, not divisible by 400 in common year" {
    try testing.expect(!isLeapYear(2100));
}
test "year divisible by 100 but not by 3 is still not a leap year" {
    try testing.expect(!isLeapYear(1900));
}
test "year divisible by 400 is leap year" {
    try testing.expect(isLeapYear(2000));
}
test "year divisible by 400 but not by 125 is still a leap year" {
    try testing.expect(isLeapYear(2400));
}
test "year divisible by 200, not divisible by 400 in common year" {
    try testing.expect(!isLeapYear(1800));
}
