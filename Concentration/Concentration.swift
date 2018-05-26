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
    
    private(set) var cards = Array<Card>() // same as [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue) { // don't need the (newValue), done newValue automaticaly
            for index in cards.indices {
                    cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
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
