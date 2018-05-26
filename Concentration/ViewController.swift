//
//  ViewController.swift
//  Concentration//
//  Created by Jan Polzer on 5/18/18.
//  Copyright © 2018 Apps KC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2  // computed property with just get, no set
    }
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flip count: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not found in cardButtons.")
        }
        flipCount += 1
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices { // for index in  0..<cardButtons.count
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.4117507863, blue: 0.216144848, alpha: 0) : #colorLiteral(red: 1, green: 0.4117507863, blue: 0.216144848, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻", "🎃", "🍎", "🙀", "🧟‍♂️", "👿", "🦇", "🍭"]
    var emoji = Dictionary<Int, String>() // [Int: String]()
    
    
    func emoji (for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
//        if emoji[card.identifier] != nil {
//            return emoji[card.identifier]!
//        } else {
//            return "?"
//        }
//        or
        return emoji[card.identifier] ?? "?"
    }
}

