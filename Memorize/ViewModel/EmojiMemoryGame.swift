//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Raรบl Carrancรก on 02/03/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let vehicles = ["๐", "๐", "โ๏ธ", "๐", "๐", "๐", "๐", "โต๏ธ", "๐ค", "๐", "๐", "๐"].shuffled()
    private static let fruits = ["๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐ฅญ", "๐"].shuffled()
    private static let sports = ["โท", "๐", "๐ช", "๐๏ธโโ๏ธ", "๐คผโโ๏ธ", "๐คธโโ๏ธ", "โน๏ธโโ๏ธ", "๐คพโโ๏ธ", "๐คบ", "๐๏ธโโ๏ธ", "๐โโ๏ธ", "๐โโ๏ธ", "๐คฝโโ๏ธ", "๐ฃโโ๏ธ", "๐งโโ๏ธ", "๐ตโโ๏ธ"].shuffled()
    private static let girls = ["๐ฎโโ๏ธ", "๐ทโโ๏ธ", "๐โโ๏ธ", "๐ต๏ธโโ๏ธ", "๐ฉโโ๏ธ", "๐ฉโ๐พ", "๐ฉโ๐ณ", "๐ฉโ๐", "๐ฉโ๐ค", "๐ฉโ๐ซ", "๐ฉโ๐ญ", "๐ฉโ๐ป", "๐ฉโ๐ผ", "๐ฉโ๐ง", "๐ฉโ๐ฌ"].shuffled()
    private static let boys = ["๐ฎโโ๏ธ", "๐ทโโ๏ธ", "๐โโ๏ธ", "๐ต๏ธโโ๏ธ", "๐จโโ๏ธ", "๐จโ๐พ", "๐จโ๐ณ", "๐จโ๐", "๐จโ๐ค", "๐จโ๐ซ", "๐จโ๐ญ", "๐จโ๐ป", "๐จโ๐ผ", "๐จโ๐ง", "๐จโ๐ฌ"].shuffled()
    private static let animals = ["๐ถ", "๐ฑ", "๐ญ", "๐น", "๐ฐ", "๐ฆ", "๐ป", "๐ผ", "๐จ", "๐ฏ", "๐ฆ", "๐ฎ", "๐ท", "๐ธ", "๐", "๐ฆ", "๐ฆ", "๐ฆ"].shuffled()
    private static let flags = ["๐ฉ๐ช", "๐ฉ๐ฟ", "๐ฆ๐ท", "๐ฆ๐บ", "๐ฆ๐น", "๐ง๐ญ", "๐ง๐ช", "๐ง๐ท", "๐จ๐ฆ", "๐จ๐ฟ", "๐จ๐ฑ", "๐จ๐ณ", "๐จ๐ด", "๐ฐ๐ท", "๐จ๐ท", "๐ญ๐ท", "๐จ๐บ", "๐ฉ๐ฐ", "๐ช๐จ", "๐ช๐ฌ", "๐ฆ๐ช" ,"๐ช๐ธ" ,"๐บ๐ธ" ,"๐ซ๐ฎ", "๐ซ๐ท", "๐ฌ๐ท", "๐ฎ๐ณ", "๐ฎ๐ท", "๐ฎ๐ช", "๐ฎ๐ฑ", "๐ฎ๐น", "๐ฏ๐ฒ", "๐ฏ๐ต", "๐ฑ๐ง", "๐ฒ๐พ", "๐ฒ๐ฝ", "๐ณ๐ฌ", "๐ณ๐ด", "๐ณ๐ฟ", "๐ณ๐ฑ", "๐ต๐น", "๐ฌ๐ง", "๐ด๓?ง๓?ข๓?ฅ๓?ฎ๓?ง๓?ฟ", "๐ธ๐ฌ", "๐ฟ๐ฆ", "๐ธ๐ช", "๐จ๐ญ", "๐น๐ญ", "๐น๐ณ", "๐น๐ท", "๐บ๐ฆ", "๐บ๐พ", "๐ป๐ช"]
    
    private(set) static var vehiclesTheme = Theme(name: .vehicles, content: vehicles, cardPairs: 8)
    private(set) static var fruitsTheme = Theme(name: .fruits, content: fruits, cardPairs: 20)
    private(set) static var sportsTheme = Theme(name: .sports, content: sports, cardPairs: 7)
    private(set) static var girlsTheme = Theme(name: .girls, content: girls, cardPairs: 8)
    private(set) static var boysTheme = Theme(name: .boys, content: boys, cardPairs: 8)
    private(set) static var animalsTheme = Theme(name: .animals, content: animals, cardPairs: 10)
    private(set) static var flagsTheme = Theme(name: .flags, content: flags, cardPairs: 15)
    
    private(set) static var themes = [vehiclesTheme, fruitsTheme, sportsTheme, girlsTheme, boysTheme, animalsTheme, flagsTheme]
    
    
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
    
    var cards: Array<Card> {
        return model.cards
    }
    
    enum ThemeName: String {
        case vehicles = "Vehicles"
        case fruits = "Fruits"
        case sports = "Sports"
        case girls = "Girls"
        case boys = "Boys"
        case animals = "Animals"
        case flags = "Flags"
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
        case .flags:
            return .purple
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
