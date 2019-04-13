//
//  ViewController.swift
//  Concetration
//
//  Created by BeemoLin on 2019/4/8.
//  Copyright © 2019 BeemoLin. All rights reserved.
//

import UIKit

class ConcetrationViewController: UIViewController {
    // private var emojiChoices = ["🎃", "🐰", "🐧", "🌝", "🌹", "🌎", "🌟", "🌈"]
    private var emojiChoices = "🎃🐰🐧🌝🌹🌎🌟🌈"
    private var emoji = [Card: String]()
    private lazy var game = Concetration(numberOfPairsOfCards: numberOfPairOfCards)
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let r = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: r)
            emoji[card] = String(emojiChoices.remove(at: randomIndex))
        }
        return emoji[card] ?? "?"
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
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
        
        updateFlipCountLabel()
    }
    
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func startNewGame(_ sender: UIButton) {
        emojiChoices = "🎃🐰🐧🌝🌹🌎🌟🌈"
        emoji = [Card: String]()
        for button in cardButtons {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        game = Concetration(numberOfPairsOfCards: numberOfPairOfCards)
        
        updateFlipCountLabel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
}
