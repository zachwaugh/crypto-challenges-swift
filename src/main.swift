//
//  main.swift
//  Crypto-challenge
//
//  Created by Zach Waugh on 8/15/14.
//  Copyright (c) 2014 Zach Waugh. All rights reserved.
//

import Foundation

func runAllChallenges() {
    let challenges = [challenge1, challenge2, challenge3, challenge4, challenge5, challenge6]
    var challengeNumber = 0
    
    for challenge in challenges {
        print("Challenge \(++challengeNumber)...")
        let result = challenge()
        println(result ? "passed" : "failed")
    }
}

runAllChallenges()
