//
//  Card.swift
//  Concetration
//
//  Created by BeemoLin on 2019/4/9.
//  Copyright © 2019 BeemoLin. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMetched = false
    private var identifier: Int
    
    private static var identifierFatory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFatory += 1
        return identifierFatory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
