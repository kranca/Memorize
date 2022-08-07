//
//  ThemeStore.swift
//  Memorize
//
//  Created by Raúl Carrancá on 06/08/22.
//

import SwiftUI

struct Theme: Identifiable, Codable, Hashable {
    var name: String
    var rgbaColor: RGBAColor
    var emojis: String
    var cardPairs: Int
    var id: Int
    
    var color: Color {
        get { Color(rgbaColor: rgbaColor) }
        
        set { rgbaColor = RGBAColor(color: newValue) }
    }
    
    fileprivate init(name: String, rgbaColor: RGBAColor, emojis: String, cardPairs: Int, id: Int) {
        self.name = name
        self.rgbaColor = rgbaColor
        self.emojis = emojis
        self.cardPairs = cardPairs
        self.id = id
    }
}

struct RGBAColor: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}

class ThemeStore: ObservableObject {
    let name: String
    
    @Published var themes = [Theme]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultKey: String {
        "ThemeStore:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultKey)
        //print(UserDefaults.standard.data(forKey: userDefaultKey)!.indices)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultKey), let decodedThemes = try? JSONDecoder().decode([Theme].self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        
        if themes.isEmpty {
            insertTheme(named: "Vehicles", color: .red, emojis: "🚗🚑✈️🚀🚌🚓🚁⛵️🚤🚂🚝🏎", cardPairs: 8)
            insertTheme(named: "Sports", color: .orange, emojis: "⛷🏂🪂🏋️‍♀️🤼‍♀️🤸‍♀️⛹️‍♀️🤾‍♂️🤺🏌️‍♂️🏄‍♀️🏊‍♂️🤽‍♀️🚣‍♂️🧗‍♂️🚵‍♂️", cardPairs: 7)
            insertTheme(named: "Boys", color: .blue, emojis: "👮‍♂️👷‍♂️💂‍♂️🕵️‍♂️👨‍⚕️👨‍🌾👨‍🍳👨‍🎓👨‍🎤👨‍🏫👨‍🏭👨‍💻👨‍💼👨‍🔧👨‍🔬", cardPairs: 8)
            insertTheme(named: "Girls", color: .pink, emojis: "👮‍♀️👷‍♀️💂‍♀️🕵️‍♀️👩‍⚕️👩‍🌾👩‍🍳👩‍🎓👩‍🎤👩‍🏫👩‍🏭👩‍💻👩‍💼👩‍🔧👩‍🔬", cardPairs: 8)
        }
    }
    
    // MARK: - Intents
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }
    
    func insertTheme(named name: String, color: Color = .black, emojis: String? = nil, cardPairs: Int, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(name: name, color: color, emojis: emojis ?? "", cardPairs: cardPairs, id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
}
