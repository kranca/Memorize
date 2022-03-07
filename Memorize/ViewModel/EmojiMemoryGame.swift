//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Raúl Carrancá on 02/03/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let vehicles = ["🚗", "🚑", "✈️", "🚀", "🚌", "🚓", "🚁", "⛵️", "🚤", "🚂", "🚝", "🏎"].shuffled()
    private static let fruits = ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍒", "🍑", "🥭", "🍍"].shuffled()
    private static let sports = ["⛷", "🏂", "🪂", "🏋️‍♀️", "🤼‍♀️", "🤸‍♀️", "⛹️‍♀️", "🤾‍♂️", "🤺", "🏌️‍♂️", "🏄‍♀️", "🏊‍♂️", "🤽‍♀️", "🚣‍♂️", "🧗‍♂️", "🚵‍♂️"].shuffled()
    private static let girls = ["👮‍♀️", "👷‍♀️", "💂‍♀️", "🕵️‍♀️", "👩‍⚕️", "👩‍🌾", "👩‍🍳", "👩‍🎓", "👩‍🎤", "👩‍🏫", "👩‍🏭", "👩‍💻", "👩‍💼", "👩‍🔧", "👩‍🔬"].shuffled()
    private static let boys = ["👮‍♂️", "👷‍♂️", "💂‍♂️", "🕵️‍♂️", "👨‍⚕️", "👨‍🌾", "👨‍🍳", "👨‍🎓", "👨‍🎤", "👨‍🏫", "👨‍🏭", "👨‍💻", "👨‍💼", "👨‍🔧", "👨‍🔬"].shuffled()
    private static let animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐒", "🦆", "🦅", "🦉"].shuffled()
    
    private(set) static var vehiclesTheme = Theme(name: .vehicles, content: vehicles, cardPairs: 8)
    private(set) static var fruitsTheme = Theme(name: .fruits, content: fruits, cardPairs: 20)
    private(set) static var sportsTheme = Theme(name: .sports, content: sports, cardPairs: 7)
    private(set) static var girlsTheme = Theme(name: .girls, content: girls, cardPairs: 8)
    private(set) static var boysTheme = Theme(name: .boys, content: boys, cardPairs: 8)
    private(set) static var animalsTheme = Theme(name: .animals, content: animals, cardPairs: 10)
    
    private(set) static var themes = [vehiclesTheme, fruitsTheme, sportsTheme, girlsTheme, boysTheme, animalsTheme]
    
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame(pairsOfCards: theme.cardPairs) { index in
            theme.content[index]
        }
    }
    
    init(theme: Theme) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    @Published private var theme: Theme
    
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    enum ThemeName: String {
        case vehicles = "Vehicles"
        case fruits = "Fruits"
        case sports = "Sports"
        case girls = "Girls"
        case boys = "Boys"
        case animals = "Animals"
    }
    
    struct Theme {
        var name: ThemeName
        var content: [String]
        var cardPairs: Int
        
        init(name: ThemeName, content: [String], cardPairs: Int) {
            self.name = name
            self.content = content
            if cardPairs <= content.count {
                self.cardPairs = cardPairs
            } else {
                self.cardPairs = content.count
            }
        }
        
        init(name: ThemeName, content: [String]) {
            self.name = name
            self.content = content
            self.cardPairs = content.count
        }
    }
    
    // MARK: - Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    // MARK: - Additional Methods
    // method intended for themes overview
    func extractEmojis() -> String {
        var emojis = ""
        
        for index in 0..<theme.cardPairs {
            emojis += theme.content[index]
        }
        return emojis
    }
    
    // additional method for color selection
    func selectColor() -> Color {
        switch theme.name {
        case .vehicles:
            return .red
        case .fruits:
            return .green
        case .sports:
            return .orange
        case .girls:
            return .pink
        case .boys:
            return .blue
        case .animals:
            return .yellow
        }
    }
    
    // computed property for theme name
    var name: String {
        theme.name.rawValue
    }
    
    // additional method for creating a new game
    func startNewGame() {
        theme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    // additional method to get score
    func getScore() -> Int {
        model.score
    }
}
