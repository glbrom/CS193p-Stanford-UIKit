//
//  ViewController.swift
//  Twin Game
//
//  Created by Macbook on 18.12.2022.
//

import UIKit

class TwinViewController: UIViewController {
    
    private lazy var game: Twin = Twin(numberOfPairsOfCard: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.systemGreen]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipsCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipsCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
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
        if cardButtons != nil {
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
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    //    private var emojiChoices = ["🐶", "🐼", "🐵", "🦁", "🐸", "🐴", "🐷"]
    
    private var emojiChoices = "🐶🐼🐵🦁🐸🐴🐷🐦🐣🪱🐢🦐🪲🐕🦢🦮🐋🐠🎄🦖🐔🐽"
    
    private var emoji = [Card : String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomSstringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomSstringIndex))
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



