// Given a word, compute the Scrabble score for that word.
//
// Letter Values
// You'll need these:
//
// Letter                           Value
// A, E, I, O, U, L, N, R, S, T       1
// D, G                               2
// B, C, M, P                         3
// F, H, V, W, Y                      4
// K                                  5
// J, X                               8
// Q, Z                               10
// Examples
// "cabbage" should be scored as worth 14 points:
//
// 3 points for C
// 1 point for A, twice
// 3 points for B, twice
// 2 points for G
// 1 point for E
// And to total:
//
// 3 + 2*1 + 2*3 + 2 + 1
// = 3 + 2 + 6 + 3
// = 5 + 9
// = 14
// Extensions
// You can play a double or a triple letter.
// You can play a double or a triple word.

const std = @import("std");

pub fn score(s: []const u8) u32 {
    var total: u32 = 0;

    for (s) |char| {
        total += switch (std.ascii.toUpper(char)) {
            'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T' => 1,
            'D', 'G' => 2,
            'B', 'C', 'M', 'P' => 3,
            'F', 'H', 'V', 'W', 'Y' => 4,
            'K' => 5,
            'J', 'X' => 8,
            'Q', 'Z' => 10,
            else => 0,
        };
    }
    return total;
}

const testing = std.testing;

test "lowercase letter" {
    const expected: u32 = 1;
    const actual = score("a");
    try testing.expectEqual(expected, actual);
}
test "uppercase letter" {
    const expected: u32 = 1;
    const actual = score("A");
    try testing.expectEqual(expected, actual);
}
test "valuable letter" {
    const expected: u32 = 4;
    const actual = score("f");
    try testing.expectEqual(expected, actual);
}
test "short word" {
    const expected: u32 = 2;
    const actual = score("at");
    try testing.expectEqual(expected, actual);
}
test "short, valuable word" {
    const expected: u32 = 12;
    const actual = score("zoo");
    try testing.expectEqual(expected, actual);
}
test "medium word" {
    const expected: u32 = 6;
    const actual = score("street");
    try testing.expectEqual(expected, actual);
}
test "medium, valuable word" {
    const expected: u32 = 22;
    const actual = score("quirky");
    try testing.expectEqual(expected, actual);
}
test "long, mixed-case word" {
    const expected: u32 = 41;
    const actual = score("OxyphenButazone");
    try testing.expectEqual(expected, actual);
}
test "english-like word" {
    const expected: u32 = 8;
    const actual = score("pinata");
    try testing.expectEqual(expected, actual);
}
test "empty input" {
    const expected: u32 = 0;
    const actual = score("");
    try testing.expectEqual(expected, actual);
}
test "entire alphabet available" {
    const expected: u32 = 87;
    const actual = score("abcdefghijklmnopqrstuvwxyz");
    try testing.expectEqual(expected, actual);
}
