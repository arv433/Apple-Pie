//
//  Game.swift
//  Apple Pie
//
//  Created by Arvin Zojaji on 2018-11-04.
//  Copyright © 2018 Arvin Zojaji. All rights reserved.
//

import Foundation

struct Game {
    var word: String, incorrectMovesRemaining: Int, guessedLetters: [Character]

    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
