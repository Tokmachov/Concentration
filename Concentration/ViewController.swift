//
//  ViewController.swift
//  Concentration
//
//  Created by mac on 02/09/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    @IBOutlet weak private var flipCountLabel: UILabel! {
        didSet {
            flipCountLabel.text = "Flips: \(game.flipCount)"
        }
    }
    @IBOutlet weak private var scoreLabel: UILabel! {
        didSet {
            scoreLabel.text = "Score: \(game.score)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.backgroundColor
        cardButtons.forEach { $0.backgroundColor = theme.cardBackColor }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak private var bonusLabel: UILabel! {
        didSet {
            bonusLabel.text = "Bonus: \(game.bonusPoints)"
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of:sender) {
            game.choseCard(at: cardNumber)
            updateFromModel()
        }
    }
    @IBAction func startNewGame() {
        game.startNewGame()
        prepareUIForNewGame()
        updateFromModel()
    }
    private func updateFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : theme.cardBackColor
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
        bonusLabel.text = "Bonus: \(game.bonusPoints)"
    }
    private func prepareUIForNewGame() {
        emoji = [:]
        theme = Themes.randomTheme()
        view.backgroundColor = theme.backgroundColor
    }
    private var emoji = [Card:String]()
    private lazy var theme = Themes.randomTheme()

    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, !theme.emoji.isEmpty {
            let index = theme.emoji.indices.randomElement()!
            emoji[card] = theme.emoji.remove(at: index)
        }
        return emoji[card] ?? "?"
    }
}

extension ViewController {
    private struct Theme {
        var backgroundColor: UIColor
        var cardBackColor: UIColor
        var emoji: [String]
    }
    private struct Themes {
            static var themes = [
            Theme(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardBackColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), emoji:
                ["👻","🎃","🕷", "🍭", "👹", "🤡", "👺", "🦇", "🕸"]),
            Theme(backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), cardBackColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), emoji:
                ["🐶","🐭","🐸","🐒","🐔","🐣","🐥","🦅","🦉","🐝"]),
            Theme(backgroundColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), cardBackColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), emoji:
                ["🥳","🥰","🤩","😡","🥶","😱","🤢","🤮","😈","🥵"]),
            Theme(backgroundColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), cardBackColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), emoji:
                ["🏓","🏈","🥎","⛷","🤼‍♀️","🤸🏽‍♀️","⛹🏾‍♂️","🤾🏿‍♀️","🏌🏾‍♂️","🤽🏼‍♀️"]),
            Theme(backgroundColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), cardBackColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), emoji:
                ["📡","🕰","🖨","📸","🎥","☎️","⏰","⚖️","💎","🔦"]),
            Theme(backgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), cardBackColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), emoji:
                ["❤️","🧡","💙","🖤","💜","💖","💗","💝","💞","💘"])
        ]
        static func randomTheme() -> Theme {
            return themes.randomElement()!
        }
    }
}


