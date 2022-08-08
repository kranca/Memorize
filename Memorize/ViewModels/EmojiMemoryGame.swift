//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Raúl Carrancá on 02/03/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
//    private static let vehicles = ["🚗", "🚑", "✈️", "🚀", "🚌", "🚓", "🚁", "⛵️", "🚤", "🚂", "🚝", "🏎"].shuffled()
//    private static let fruits = ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍒", "🍑", "🥭", "🍍"].shuffled()
//    private static let sports = ["⛷", "🏂", "🪂", "🏋️‍♀️", "🤼‍♀️", "🤸‍♀️", "⛹️‍♀️", "🤾‍♂️", "🤺", "🏌️‍♂️", "🏄‍♀️", "🏊‍♂️", "🤽‍♀️", "🚣‍♂️", "🧗‍♂️", "🚵‍♂️"].shuffled()
//    private static let girls = ["👮‍♀️", "👷‍♀️", "💂‍♀️", "🕵️‍♀️", "👩‍⚕️", "👩‍🌾", "👩‍🍳", "👩‍🎓", "👩‍🎤", "👩‍🏫", "👩‍🏭", "👩‍💻", "👩‍💼", "👩‍🔧", "👩‍🔬"].shuffled()
//    private static let boys = ["👮‍♂️", "👷‍♂️", "💂‍♂️", "🕵️‍♂️", "👨‍⚕️", "👨‍🌾", "👨‍🍳", "👨‍🎓", "👨‍🎤", "👨‍🏫", "👨‍🏭", "👨‍💻", "👨‍💼", "👨‍🔧", "👨‍🔬"].shuffled()
//    private static let animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐒", "🦆", "🦅", "🦉"].shuffled()
//    private static let flags = ["🇩🇪", "🇩🇿", "🇦🇷", "🇦🇺", "🇦🇹", "🇧🇭", "🇧🇪", "🇧🇷", "🇨🇦", "🇨🇿", "🇨🇱", "🇨🇳", "🇨🇴", "🇰🇷", "🇨🇷", "🇭🇷", "🇨🇺", "🇩🇰", "🇪🇨", "🇪🇬", "🇦🇪" ,"🇪🇸" ,"🇺🇸" ,"🇫🇮", "🇫🇷", "🇬🇷", "🇮🇳", "🇮🇷", "🇮🇪", "🇮🇱", "🇮🇹", "🇯🇲", "🇯🇵", "🇱🇧", "🇲🇾", "🇲🇽", "🇳🇬", "🇳🇴", "🇳🇿", "🇳🇱", "🇵🇹", "🇬🇧", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇸🇬", "🇿🇦", "🇸🇪", "🇨🇭", "🇹🇭", "🇹🇳", "🇹🇷", "🇺🇦", "🇺🇾", "🇻🇪"]
    
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let gameEmojis = theme.emojisArray
        return MemoryGame(pairsOfCards: theme.cardPairs) { index in
            gameEmojis[index]
        }
    }
    
    init(theme: Theme) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    @Published private var theme: Theme
    
    var name: String {
        theme.name
    }
    
    @Published private var model: MemoryGame<String>
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    // MARK: - Additional Methods

    // additional method for creating a new game
    func startNewGame() {
        //theme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    // additional method to get score
    func getScore() -> Int {
        model.score
    }
    
    func getThemeColor() -> Color {
        theme.color
    }
}
