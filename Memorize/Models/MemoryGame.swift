//
//  MemoryGame.swift
//  Memorize
//
//  Created by Raúl Carrancá on 02/03/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score: Int = 0
    
    private var indexOfSingleOpenCard: Int? {
        // if only one index of face up card is found return index
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        
        // when setting: close all cards except the one just set
        // newValue is value just set
        set { cards.indices.forEach({ cards[$0].isFaceUp = ($0 == newValue) }) }
    }
    
    mutating func choose(_ card: Card) {
        // if chosen card is in deck, chosen card is facing down and chosen card hasn't been matched
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            // one card is already open
            if let potentialMatchIndex = indexOfSingleOpenCard {
                // and matches latest card opened
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // both cards are matched
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    // and 2 points are given
                    score += 2 + (cards[chosenIndex].hasEarnedBonus && cards[potentialMatchIndex].hasEarnedBonus ? 1 : 0)
                }
                // if one of the cards has been seen and not matched
                if (cards[chosenIndex].hasBeenSeen || cards[potentialMatchIndex].hasBeenSeen) && (!cards[chosenIndex].isMatched || !cards[potentialMatchIndex].isMatched) {
                    // deduct 1 point
                    score -= 1
                }
                // set both cards as seen
                cards[chosenIndex].hasBeenSeen = true
                cards[potentialMatchIndex].hasBeenSeen = true
                
                // reopen chosen card, since all cards have been closed
                cards[chosenIndex].isFaceUp = true
                
            // if no other card is open
            } else {
                // game starts with indexOfSingleOpenCard = nil, therefore everytime one card is open, indexOfSingleOpenCard is asigned to chosenIndex
                indexOfSingleOpenCard = chosenIndex
            }
        }
    }
    
    init(pairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add pairsOfCards * 2 cards to array cards
        for pair in 0..<pairsOfCards {
            let content = createCardContent(pair)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards = cards.shuffled()
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        let id = UUID()
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startsUsingBonusTime()
                } else {
                    stopsUsingBonusTime()
                }
            }
        }
        var isMatched = false
        let content: CardContent
        var hasBeenSeen = false
        
        // MARK: - Bonus time

        // bonus time logic works with TimeIntervals and Date
        var bonusTimeLimit: TimeInterval = 6

        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startsUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopsUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}

// MARK: - Extensions

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}


