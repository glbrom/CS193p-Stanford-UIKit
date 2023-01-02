//
//  ViewController.swift
//  Twin Game
//
//  Created by Macbook on 18.12.2022.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game: Twin = Twin(numberOfPairsOfCard: numberOfPairsOfCards)
                               
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2 
    }
                               
    private(set) var flipCount: Int = 0 {
        didSet {
            flipsCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipsCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func touchCardButton(_ sender: UIButton) {
        
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Card : ")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateViewFromModel()  {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = .black
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? .clear : .systemGreen
            }
        }
    }
    
    private var emojiChoices = ["🐶", "🐼", "🐵", "🦁", "🐸", "🐴", "🐷"]
    
    private var emoji = [Card : String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}



