//
//  Concetration.swift
//  Concetration
//
//  Created by BeemoLin on 2019/4/9.
//  Copyright © 2019 BeemoLin. All rights reserved.
//

import Foundation

class Concetration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMetched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMetched = true
                    cards[index].isMetched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no card or two cards face up
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        var tempCards = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            tempCards += [card, card]
        }
        // TODO: Shuffle the cards
        while !tempCards.isEmpty {
            let randomIndex = Int.random(in: 0...tempCards.count - 1)
            cards.append(tempCards.remove(at: randomIndex))
        }
    }
}
