//
//  Card.swift
//  Concetration
//
//  Created by BeemoLin on 2019/4/9.
//  Copyright © 2019 BeemoLin. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMetched = false
    var identifier: Int
    
    private static var identifierFatory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFatory += 1
        return identifierFatory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
