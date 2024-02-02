// Calculate the Hamming Distance between two DNA strands.
//
// Your body is made up of cells that contain DNA. Those cells regularly wear out and need replacing, which they achieve by dividing into daughter cells. In fact, the average human body experiences about 10 quadrillion cell divisions in a lifetime!
//
// When cells divide, their DNA replicates too. Sometimes during this process mistakes happen and single pieces of DNA get encoded with the incorrect information. If we compare two strands of DNA and count the differences between them we can see how many mistakes occurred. This is known as the "Hamming Distance".
//
// We read DNA using the letters C,A,G and T. Two strands might look like this:
//
// GAGCCTACTAACGGGAT
// CATCGTAATGACGGCCT
// ^ ^ ^  ^ ^    ^^
// They have 7 differences, and therefore the Hamming Distance is 7.
//
// The Hamming Distance is useful for lots of things in science, not just biology, so it's a nice phrase to be familiar with :)
//
// Implementation notes
// The Hamming distance is only defined for sequences of equal length, so an attempt to calculate it between sequences of different lengths should not work.

pub const DnaError = error{
    EmptyDnaStrands,
    UnequalDnaStrands,
};

pub fn compute(first: []const u8, second: []const u8) DnaError!usize {
    var count: usize = 0;

    if (first.len == 0 or second.len == 0) {
        return DnaError.EmptyDnaStrands;
    }

    if (first.len != second.len) {
        return DnaError.UnequalDnaStrands;
    }

    for (first, 0..) |item, i| {
        if (second[i] != item) {
            count += 1;
        }
    }

    return count;
}

const std = @import("std");
const testing = std.testing;

test "empty strands" {
    const expected = DnaError.EmptyDnaStrands;
    const actual = compute("", "");
    try testing.expectError(expected, actual);
}
test "single letter identical strands" {
    const expected: usize = 0;
    const actual = try compute("A", "A");
    try testing.expectEqual(expected, actual);
}
test "single letter different strands" {
    const expected: usize = 1;
    const actual = try compute("G", "T");
    try testing.expectEqual(expected, actual);
}
test "long identical strands" {
    const expected: usize = 0;
    const actual = try compute("GGACTGAAATCTG", "GGACTGAAATCTG");
    try testing.expectEqual(expected, actual);
}
test "long different strands" {
    const expected: usize = 9;
    const actual = try compute("GGACGGATTCTG", "AGGACGGATTCT");
    try testing.expectEqual(expected, actual);
}
test "disallow first strand longer" {
    const expected = DnaError.UnequalDnaStrands;
    const actual = compute("AATG", "AAA");
    try testing.expectError(expected, actual);
}
test "disallow second strand longer" {
    const expected = DnaError.UnequalDnaStrands;
    const actual = compute("ATA", "AGTG");
    try testing.expectError(expected, actual);
}
test "disallow left empty strand" {
    const expected = DnaError.EmptyDnaStrands;
    const actual = compute("", "G");
    try testing.expectError(expected, actual);
}
test "disallow right empty strand" {
    const expected = DnaError.EmptyDnaStrands;
    const actual = compute("G", "");
    try testing.expectError(expected, actual);
}
