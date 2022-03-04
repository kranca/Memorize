//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Raúl Carrancá on 02/03/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🚗", "🚑", "✈️", "🚀", "🚌", "🚓", "🚁", "⛵️", "🚤", "🚂", "🚝", "🏎"]
    static let fruits = ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍒", "🍑", "🥭", "🍍"]
    static let sports = ["⛷", "🏂", "🪂", "🏋️‍♀️", "🤼‍♀️", "🤸‍♀️", "⛹️‍♀️", "🤾‍♂️", "🤺", "🏌️‍♂️", "🏄‍♀️", "🏊‍♂️", "🤽‍♀️", "🚣‍♂️", "🧗‍♂️", "🚵‍♂️"]
    
    static func createMemoryGame(theme: [String]) -> MemoryGame<String> {
        MemoryGame(pairsOfCards: 8) { index in
            theme[index]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame(theme: sports.shuffled())
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    enum gameTheme {
        case transport, fruits, sports
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
