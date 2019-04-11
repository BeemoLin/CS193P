//
//  ViewController.swift
//  Concetration
//
//  Created by BeemoLin on 2019/4/8.
//  Copyright © 2019 BeemoLin. All rights reserved.
//

import UIKit

class ConcetrationViewController: UIViewController {
    private var emojiChoices = ["🎃", "🐰", "🐧", "🌝", "🌹", "🌎", "🌟", "🌈"]
    private lazy var game = Concetration(numberOfPairsOfCards: numberOfPairOfCards)
    
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        emojiChoices = ["🎃", "🐰", "🐧", "🌝", "🌹", "🌎", "🌟", "🌈"]
        emoji = [Int: String]()
        for button in cardButtons {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        game = Concetration(numberOfPairsOfCards: numberOfPairOfCards)
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMetched ? #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0...emojiChoices.count - 1)
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
