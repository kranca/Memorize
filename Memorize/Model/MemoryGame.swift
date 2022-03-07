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
    
    private var indexOfSingleOpenCard: Int?
    
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
                    score += 2
                }
                // if one of the cards has been seen and not matched
                if (cards[chosenIndex].hasBeenSeen || cards[potentialMatchIndex].hasBeenSeen) && (!cards[chosenIndex].isMatched || !cards[potentialMatchIndex].isMatched) {
                    // deduct 1 point
                    score -= 1
                }
                // set both cards as seen
                cards[chosenIndex].hasBeenSeen = true
                cards[potentialMatchIndex].hasBeenSeen = true
                // return to start condition
                indexOfSingleOpenCard = nil
            // if no other card is open
            } else {
                // close all cards
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                // game starts with indexOfSingleOpenCard = nil, therefore everytime one card is open, indexOfSingleOpenCard is asigned to chosenIndex
                indexOfSingleOpenCard = chosenIndex
            }
            // reopen chosen card, since all cards have been closed
            cards[chosenIndex].isFaceUp.toggle()
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
    
    struct Card: Identifiable {
        let id = UUID()
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var hasBeenSeen = false
    }
}
