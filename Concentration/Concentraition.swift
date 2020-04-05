//
//  Concentraition.swift
//  Concentration
//
//  Created by mac on 04/09/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var indexOfOneAndOnlyOneFaceUpCard: Int? {
        get {
            let faceUpCads = cards.filter { $0.isFaceUp }
            if faceUpCads.count == 1 {
                return cards.firstIndex { $0.isFaceUp == true }
            } else {
                return nil
            }
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    private(set) var cards = [Card]()
    private(set) var score = 0
    var bonusPoints: Int {
        let bonus = (20 - Int(-startDate.timeIntervalSinceNow))
        return bonus > 0 ? bonus : 0
    }
    private(set) var flipCount = 0
    private(set) var startDate = Date()
    
    
    func choseCard(at index: Int) {
        assert(cards.indices.contains(index), "Consentration.choseCard(at:\(index): Index do not belong to card indices")
        guard !cards[index].isFaceUp else { return }
        guard !cards[index].isMatched else { return }
        
        if let matchIndex = indexOfOneAndOnlyOneFaceUpCard {
            if cardsAreMatchAtIndices(index, matchIndex) {
                markCardsMatchedAtIndices(index, matchIndex)
                score += 2
            } else {
                score = bothBeenSeenAtIndexes(index, matchIndex) ? score - 1 : score
            }
        } else {
            indexOfOneAndOnlyOneFaceUpCard = index
        }
        flipCount += 1
        cards[index].seen = true
        cards[index].isFaceUp = true
    }
    
    func startNewGame() {
        indexOfOneAndOnlyOneFaceUpCard = nil
        markAllCardsUnmatched()
        markAllCardsUnseen()
        score = 0
        flipCount = 0
        startDate = Date()
    }
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards): There must be at leas one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = cards.shuffled()
    }
}

extension Concentration {
    
    private func cardsAreMatchAtIndices(_ index1: Int, _ index2: Int) -> Bool {
        if cards[index1] == cards[index2] {
            return true
        }
        return false
    }
    private func markCardsMatchedAtIndices(_ index1: Int, _ index2: Int) {
        cards[index1].isMatched = true
        cards[index2].isMatched = true
    }
    private func markAllCardsUnmatched() {
        for cardIndex in cards.indices {
            cards[cardIndex].isMatched = false
        }
    }
    private func bothBeenSeenAtIndexes(_ index1: Int, _ index2: Int) -> Bool {
        if cards[index1].seen && cards[index2].seen {
            return true
        } else {
            return false
        }
    }
    private func markAllCardsUnseen() {
        for cardIndex in cards.indices {
            cards[cardIndex].seen = false
        }
    }
}


