//
//  ViewController.swift
//  Apple Pie
//
//  Created by Arvin Zojaji on 2018-10-30.
//  Copyright © 2018 Arvin Zojaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentGame: Game!
    var listOfWords: [String] = ["cat", "dog", "monkey", "ape", "snake", "chicken", "dinosaur", "elephant", "kangaroo", "raccoon", "hippopotamus", "jaguar", "lion", "panther", "giraffe", "horse"]
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    let incorrectMovesAllowed = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newRound()
    }
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }

    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }

    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter).uppercased())
        }
        correctWordLabel.text = letters.joined(separator: " ")
        scoreLabel.text = "Wins: \(totalWins) Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)-1")
    }

    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }

    // outlet declarations
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!

    // action declarations
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
}

