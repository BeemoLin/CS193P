//
//  Concetration.swift
//  Concetration
//
//  Created by BeemoLin on 2019/4/9.
//  Copyright © 2019 BeemoLin. All rights reserved.
//

import Foundation

struct Concetration
{
    var flipCount = 0
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            // Closure
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMetched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMetched = true
                    cards[index].isMetched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): You must have at least one pair of cards")
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
