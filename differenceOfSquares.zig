// Find the difference between the square of the sum and the sum of the squares of the first N natural numbers.
//
// The square of the sum of the first ten natural numbers is (1 + 2 + ... + 10)² = 55² = 3025.
//
// The sum of the squares of the first ten natural numbers is 1² + 2² + ... + 10² = 385.
//
// Hence the difference between the square of the sum of the first ten natural numbers and the sum of the squares of the first ten natural numbers is 3025 - 385 = 2640.
//
// You are not expected to discover an efficient solution to this yourself from first principles; research is allowed, indeed, encouraged. Finding the best algorithm for the problem is a key skill in software engineering.

pub fn squareOfSum(number: usize) usize {
    var temp: usize = 0;
    var index: usize = 1;

    while (index <= number) {
        temp += index;
        index += 1;
    }

    return temp * temp;
}

pub fn sumOfSquares(number: usize) usize {
    var temp: usize = 0;
    var index: usize = 1;

    while (index <= number) : (index += 1) {
        temp += index * index;
    }

    return temp;
}

pub fn differenceOfSquares(number: usize) usize {
    var x: usize = sumOfSquares(number);
    var y: usize = squareOfSum(number);

    return y - x;
}

const std = @import("std");
const testing = std.testing;

test "square of sum up to 1" {
    const expected: usize = 1;
    const actual = squareOfSum(1);
    try testing.expectEqual(expected, actual);
}
test "square of sum up to 5" {
    const expected: usize = 225;
    const actual = squareOfSum(5);
    try testing.expectEqual(expected, actual);
}
test "square of sum up to 100" {
    const expected: usize = 25_502_500;
    const actual = squareOfSum(100);
    try testing.expectEqual(expected, actual);
}
test "sum of squares up to 1" {
    const expected: usize = 1;
    const actual = sumOfSquares(1);
    try testing.expectEqual(expected, actual);
}
test "sum of squares up to 5" {
    const expected: usize = 55;
    const actual = sumOfSquares(5);
    try testing.expectEqual(expected, actual);
}
test "sum of squares up to 100" {
    const expected: usize = 338_350;
    const actual = sumOfSquares(100);
    try testing.expectEqual(expected, actual);
}
test "difference of squares up to 1" {
    const expected: usize = 0;
    const actual = differenceOfSquares(1);
    try testing.expectEqual(expected, actual);
}
test "difference of squares up to 5" {
    const expected: usize = 170;
    const actual = differenceOfSquares(5);
    try testing.expectEqual(expected, actual);
}
test "difference of squares up to 100" {
    const expected: usize = 25_164_150;
    const actual = differenceOfSquares(100);
    try testing.expectEqual(expected, actual);
}
