//
//  Concentration.swift
//  Concentration
//
//  Created by Jan Polzer on 5/18/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import Foundation
import GameplayKit

class Concentration {
    
    var cards = Array<Card>() // same as [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int? 
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards of 2 cards are face up
                // turn them face down
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for identifier in 0..<numberOfPairsOfCards { // _ = identifier
            let card = Card(identifier: identifier)
            cards += [card, card]
//            or
//            let matchnigCard = Card(identifier: identifier)
//            or
//            cards.append(card)
//            cards.append(card)
        }
        
        // Shuffle the cards
        cards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards) as! [Card]
    }
    
}
