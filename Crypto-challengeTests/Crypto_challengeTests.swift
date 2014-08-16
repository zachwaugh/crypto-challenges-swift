//
//  Crypto_challengeTests.swift
//  Crypto-challengeTests
//
//  Created by Zach Waugh on 8/16/14.
//  Copyright (c) 2014 Zach Waugh. All rights reserved.
//

import Cocoa
import XCTest

class Crypto_challengeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDecodeHex() {
        let hex = "007fff"
        let bytes = decodeHex(hex)
        let expected: [Byte] = [0, 127, 255]
        XCTAssertTrue(bytes == expected)
    }
    
    func testEncodeHex() {
        let bytes: [Byte] = [0, 127, 255]
        let hex = encodeHex(bytes)
        let expected = "007fff"
        XCTAssertEqual(hex, expected)
    }
    
    func testByteToHex() {
        XCTAssertEqual(byteToHex(0), "00")
        XCTAssertEqual(byteToHex(127), "7f")
        XCTAssertEqual(byteToHex(255), "ff")
    }
    
    func testStringifyBuffer() {
        let buffer: [Byte] = [65, 66, 67, 100, 101, 102]
        XCTAssertEqual(stringifyBuffer(buffer), "ABCdef")
    }
}
