// Instructions
// Determine if a word or phrase is an
//
// An isogram (also known as a "non-pattern word") is a word or phrase without a repeating letter, however spaces and hyphens are allowed to appear multiple times.
//
// Examples of isograms:
//
// lumberjacks
// background
// downstream
// six-year-old
// The word isograms, however, is not an isogram, because the s repeats.

pub fn isIsogram(str: []const u8) bool {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var map = std.AutoHashMap(u8, usize).init(
        allocator,
    );
    defer map.deinit();

    var count: usize = 0;

    for (str) |c| {
        var char: u8 = std.ascii.toLower(c);
        if (!std.ascii.isAlphabetic(char)) continue;
        count = map.get(char) orelse 0;

        switch (count) {
            0 => {
                map.put(char, 1) catch |err| {
                    std.debug.print("HashMap put error: {}", .{err});
                };
            },
            else => {
                return false;
            },
        }
    }

    return true;
}

const std = @import("std");
const testing = std.testing;
test "empty string" {
    try testing.expect(isIsogram(""));
}
test "isogram with only lower case characters" {
    try testing.expect(isIsogram("isogram"));
}
test "word with one duplicated character" {
    try testing.expect(!isIsogram("eleven"));
}
test "word with one duplicated character from the end of the alphabet" {
    try testing.expect(!isIsogram("zzyzx"));
}
test "longest reported english isogram" {
    try testing.expect(isIsogram("subdermatoglyphic"));
}
test "word with duplicated character in mixed case" {
    try testing.expect(!isIsogram("Alphabet"));
}
test "word with duplicated character in mixed case, lowercase first" {
    try testing.expect(!isIsogram("alphAbet"));
}
test "hypothetical isogrammic word with hyphen" {
    try testing.expect(isIsogram("thumbscrew-japingly"));
}
test "hypothetical word with duplicated character following hyphen" {
    try testing.expect(!isIsogram("thumbscrew-jappingly"));
}
test "isogram with duplicated hyphen" {
    try testing.expect(isIsogram("six-year-old"));
}
test "made-up name that is an isogram" {
    try testing.expect(isIsogram("Emily Jung Schwartzkopf"));
}
test "duplicated character in the middle" {
    try testing.expect(!isIsogram("accentor"));
}
test "same first and last characters" {
    try testing.expect(!isIsogram("angola"));
}
test "word with duplicated character and with two hyphens" {
    try testing.expect(!isIsogram("up-to-date"));
}
