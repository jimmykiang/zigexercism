// Instructions
// The Collatz Conjecture or 3x+1 problem can be summarized as follows:
//
// Take any positive integer n. If n is even, divide n by 2 to get n / 2. If n is odd, multiply n by 3 and add 1 to get 3n + 1. Repeat the process indefinitely. The conjecture states that no matter which number you start with, you will always reach 1 eventually.
//
// Given a number n, return the number of steps required to reach 1.
//
// Examples
// Starting with n = 12, the steps would be as follows:
//
// 12
// 6
// 3
// 10
// 5
// 16
// 8
// 4
// 2
// 1
// Resulting in 9 steps. So for input n = 12, the return value would be 9.
//
// Error handling
// For this exercise you must add an error set ComputationError that contains the IllegalArgument error. Remember to make it public! The steps function must return ComputationError.IllegalArgument when its input is equal to zero.
//
// Later exercises will usually omit explicit instructions like this. In general, Exercism expects you to read the test file when implementing your solution.

// Please implement the `ComputationError.IllegalArgument` error.

pub const ComputationError = error {
    IllegalArgument,
};

pub fn steps(number: usize) anyerror!usize {
    var result: usize = number;
    var stepCount: usize = 0;

    if (number == 0) return ComputationError.IllegalArgument;

    while (result > 1) : (stepCount += 1){
        if (result % 2 == 0) {
            result = result / 2;
        } else {
            result = (result * 3) + 1;
        }
    }

    return stepCount;
}

const std = @import("std");
const testing = std.testing;

test "zero steps for one" {
    const expected: usize = 0;
    const actual = try steps(1);
    try testing.expectEqual(expected, actual);
}
test "divide if even" {
    const expected: usize = 4;
    const actual = try steps(16);
    try testing.expectEqual(expected, actual);
}
test "even and odd steps" {
    const expected: usize = 9;
    const actual = try steps(12);
    try testing.expectEqual(expected, actual);
}
test "large number of even and odd steps" {
    const expected: usize = 152;
    const actual = try steps(1_000_000);
    try testing.expectEqual(expected, actual);
}
test "zero is an error" {
    const expected = ComputationError.IllegalArgument;
    const actual = steps(0);
    try testing.expectError(expected, actual);
}
