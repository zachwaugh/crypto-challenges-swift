//
//  set1.swift
//  Crypto-challenge
//
//  Created by Zach Waugh on 8/15/14.
//  Copyright (c) 2014 Zach Waugh. All rights reserved.
//

import Foundation

// -- Set 1 --
// http://cryptopals.com/sets/1/

// Challenge 1 - http://cryptopals.com/sets/1/challenges/1/
func challenge1() -> Bool {
    let input = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    let expected = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    let result = base64FromHex(input)
    
    return result == expected
}

// Challenge 2 - http://cryptopals.com/sets/1/challenges/2/
func challenge2() -> Bool {
    let input = "1c0111001f010100061a024b53535009181c"
    let key = "686974207468652062756c6c277320657965"
    let expected = "746865206b696420646f6e277420706c6179"
    let result = encodeHex(xorBuffers(decodeHex(input), decodeHex(key)))
    
    return result == expected
}

// Challenge 3 - http://cryptopals.com/sets/1/challenges/3/
func challenge3() -> Bool {
    let input = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    // This was found originally using this function, just here to make sure it still works
    let expected = "Cooking MC's like a pound of bacon"
    let buffer = decodeHex(input)
    let scores = scoreAllCharacters(buffer)
    let best = scores.first!
    
    return best.text == expected
}

// Challenge 4 - http://cryptopals.com/sets/1/challenges/4/
func challenge4() -> Bool {
    let input = readFile("challenge4-data.txt").componentsSeparatedByString("\n")
    
    // This was found originally using this function, just here to make sure it still works
    let expected = "Now that the party is jumping"
    var results: [Score] = []
    
    // Challenge 4 can take a while, outputs "." to show it's still working
    for text in input {
        let decoded = decodeHex(text)
        let scores = scoreAllCharacters(decoded)
        
        if let best = scores.first {
            print(".")
            results.append(best)
        }
    }
    
    let ranked = sorted(results, { $0.number > $1.number })
    let best = ranked.first!

    return best.text == expected
}

// Challenge 5 - http://cryptopals.com/sets/1/challenges/5/
func challenge5() -> Bool {
    let input = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"
    let key = "ICE"
    let expected = "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f"
    
    let keyBytes = bytesFromString(key)
    var index = 0
    var buffer: [Byte] = []
    
    for character in input.utf8 {
        let keyCharacter = keyBytes[index++ % keyBytes.count]
        buffer.append(keyCharacter ^ character)
    }
    
    let encrypted = encodeHex(buffer)
    return encrypted == expected
}

// Challenge 6 - http://cryptopals.com/sets/1/challenges/6/
func challenge6() -> Bool {
    let input = readFile("challenge6-data.txt")
    
    return false
}