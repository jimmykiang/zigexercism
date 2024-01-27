// You work for a company that sells fonts through their website. They'd like to show a different sentence each time someone views a font on their website. To give a comprehensive sense of the font, the random sentences should use all the letters in the English alphabet.
//
// They're running a competition to get suggestions for sentences that they can use. You're in charge of checking the submissions to see if they are valid.
//
// Note
// Pangram comes from Greek, παν γράμμα, pan gramma, which means "every letter".
//
// The best known English pangram is:
//
// The quick brown fox jumps over the lazy dog.
//
// Instructions
// Your task is to figure out if a sentence is a
//
// A pangram is a sentence using every letter of the alphabet at least once. It is case insensitive, so it doesn't matter if a letter is lower-case (e.g. k) or upper-case (e.g. K).
//
// For this exercise, a sentence is a pangram if it contains each of the 26 letters in the English alphabet.

pub fn initHashAlphabet(map: *std.AutoHashMap(u8, usize)) !void {
    for ('a'..'z' + 1) |char| {
        var temp: u8 = @intCast(char);
        try map.*.put(temp, 0);
    }

    // var iterator = map.iterator();
    // const stdout = std.io.getStdOut().writer();
    //
    // while (iterator.next()) |entry| {
    //     try stdout.print("{c}", .{entry.key_ptr.*});
    //     try stdout.print(" {d}\n", .{entry.value_ptr.*});
    // }
    //
    // try stdout.print("count: {d}\n", .{map.count()});
}

const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var map = std.AutoHashMap(u8, usize).init(
        allocator,
    );
    defer map.deinit();

    initHashAlphabet(&map) catch |err| {
        std.debug.print("Error!!! {}", .{err});
        return false;
    };

    var value: u8 = 0;
    var tempChar: u8 = 0;

    for (str) |char| {
        tempChar = std.ascii.toLower(char);

        if ((!std.ascii.isAlphabetic(tempChar))) {
            continue;
        } else if (!map.contains(tempChar)) continue;

        value = @intCast(map.get(tempChar) orelse unreachable);

        // std.debug.print("{c}", .{tempChar});
        // std.debug.print("{}", .{value});
        value += 1;

        _ = map.fetchPut(tempChar, value) catch |err| {
            std.debug.print("Error!!!: {}", .{err});
        };
        value = 0;
    }

    var iterator = map.iterator();
    // const stdout = std.io.getStdOut().writer();

    while (iterator.next()) |entry| {
        // stdout.print("{c}", .{entry.key_ptr.*}) catch |err| {
        //     std.debug.print("Error!!!: {}", .{err});
        // };
        // stdout.print(" {}\n", .{entry.value_ptr.*}) catch |err| {
        //     std.debug.print("Error!!!: {}", .{err});
        // };

        if (entry.value_ptr.* == 0) return false;
    }

    // stdout.print("count: {d}\n", .{map.count()}) catch |err| {
    //     std.debug.print("Error!!! {}", .{err});
    // };

    return true;
}

const testing = std.testing;

test "empty sentence" {
    try testing.expect(!isPangram(""));
}
test "perfect lower case" {
    try testing.expect(isPangram("abcdefghijklmnopqrstuvwxyz"));
}
test "only lower case" {
    try testing.expect(isPangram("the quick brown fox jumps over the lazy dog"));
}
test "missing the letter 'x'" {
    try testing.expect(!isPangram("a quick movement of the enemy will jeopardize five gunboats"));
}
test "missing the letter 'h'" {
    try testing.expect(!isPangram("five boxing wizards jump quickly at it"));
}
test "with underscores" {
    try testing.expect(isPangram("the_quick_brown_fox_jumps_over_the_lazy_dog"));
}
test "with numbers" {
    try testing.expect(isPangram("the 1 quick brown fox jumps over the 2 lazy dogs"));
}
test "missing letters replaced by numbers" {
    try testing.expect(!isPangram("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"));
}
test "mixed case and punctuation" {
    try testing.expect(isPangram("\"Five quacking Zephyrs jolt my wax bed.\""));
}
test "a-m and A-M are 26 different characters but not a pangram" {
    try testing.expect(!isPangram("abcdefghijklm ABCDEFGHIJKLM"));
}
test "non-alphanumeric printable ASCII" {
    try testing.expect(!isPangram(" !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"));
}
