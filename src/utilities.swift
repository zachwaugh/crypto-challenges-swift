//
//  utilities.swift
//  Crypto-challenge
//
//  Created by Zach Waugh on 8/15/14.
//  Copyright (c) 2014 Zach Waugh. All rights reserved.
//

import Foundation

func readFile(file: String) -> String {
    // Convenience function to read file specifically for this project
    let dir = __FILE__.stringByDeletingLastPathComponent!
    return String.stringWithContentsOfFile(dir + "/\(file)", encoding: NSUTF8StringEncoding, error: nil)!
}

// String subscript extension borrowed from http://oleb.net/blog/2014/07/swift-strings/
extension String {
    subscript(integerIndex: Int) -> Character {
        let index = advance(startIndex, integerIndex)
        return self[index]
    }
    
    subscript(integerRange: Range<Int>) -> String {
        let start = advance(startIndex, integerRange.startIndex)
        let end = advance(startIndex, integerRange.endIndex)
        let range = start..<end
        return self[range]
    }
}

func decodeHex(string: String) -> [Byte] {
    var bytes: [Byte] = []
    for var i = 0; i < countElements(string); i += 2 {
        let range = Range<Int>(start: i, end: i + 2)
        let substring = string[range]
        var byte: CUnsignedInt = 0
        NSScanner(string: substring).scanHexInt(&byte)
        bytes.append(Byte(byte))
    }
    
    return bytes
}

func encodeHex(bytes: [Byte]) -> String {
    return bytes.map { byteToHex($0) }.reduce("", combine: +)
}

func byteToHex(byte: Byte) -> String {
    return NSString(format: "%02x", byte)
}

func bytesFromString(string: String) -> [Byte] {
    var bytes: [Byte] = []
    for byte in string.utf8 {
        bytes.append(byte)
    }
    
    return bytes
}

func base64FromHex(string: String) -> String {
    let bytes = decodeHex(string)
    return NSData(bytes: bytes, length: bytes.count).base64EncodedStringWithOptions(NSDataBase64EncodingOptions(0))
}

func xorBuffers(buffer1: [Byte], buffer2: [Byte]) -> [Byte] {
    var result: [Byte] = []
    
    for var i = 0; i < buffer1.count; i++ {
        let byte1 = buffer1[i]
        let byte2 = buffer2[i]
        result.append(byte1 ^ byte2)
    }
    
    return result
}

func xorBuffer(buffer: [Byte], value: Int) -> [Byte] {
    return buffer.map { byte in byte ^ Byte(value) }
}

func stringifyBuffer(buffer: [Byte]) -> String {
    return buffer.map { NSString(format: "%c", $0) }.reduce("", combine: +)
}

func computeScore(string: String) -> Int {
    // Simplistic scoring of plain-text based on weighting vowels, consonants, and digits
    // Should probably take frequency into account as suggested, but this works well enough for distinguishing english from gibberish
    let vowels = [ "a", "e", "i", "o", "u" ]
    let consonants = [ "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z" ]
    let digits = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var score = 0
    for character in string {
        let char = String(character)
        if contains(vowels, char) {
            score += 10
        } else if contains(consonants, char) {
            score += 5
        } else if contains(digits, char) {
            score += 2
        } else {
            score += 1
        }
    }
    
    return score
}

struct Score {
    let text = ""
    let number = 0
}

func scoreAllCharacters(buffer: [Byte]) -> [Score] {
    // The challenge didn't specify possible range of characters that could be XOR'ed against,
    // we'll make an assumption and skip any non-printable ASCII characters
    var characters = Array(32...126)
    
    let scores = characters.map { (i: Int) -> Score in
        let result = stringifyBuffer(xorBuffer(buffer, i)).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let score = computeScore(result)
        return Score(text: result, number: score)
    }
    
    return sorted(scores, { $0.number > $1.number })
}

func hammingDistance(string1: String, string2: String) -> Int {
    var distance = 0
    
    return distance
}
