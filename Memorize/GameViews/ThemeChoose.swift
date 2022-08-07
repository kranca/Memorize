//
//  ThemeChoose.swift
//  Memorize
//
//  Created by Raúl Carrancá on 04/03/22.
//

import SwiftUI

struct ThemeChoose: View {
    let vehicleGame = EmojiMemoryGame(theme: EmojiMemoryGame.vehiclesTheme)
    let fruitsGame = EmojiMemoryGame(theme: EmojiMemoryGame.fruitsTheme)
    let sportsGame = EmojiMemoryGame(theme: EmojiMemoryGame.sportsTheme)
    let girlsGame = EmojiMemoryGame(theme: EmojiMemoryGame.girlsTheme)
    let boysGame = EmojiMemoryGame(theme: EmojiMemoryGame.boysTheme)
    let animalsGame = EmojiMemoryGame(theme: EmojiMemoryGame.animalsTheme)
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Select a theme")
                    .bold()
                    .font(.largeTitle)
                NavigationLink("\(vehicleGame.name): \(vehicleGame.extractEmojis())", destination: EmojiMemoryGameView(game: vehicleGame))
                    .padding(.top)
                NavigationLink("\(fruitsGame.name): \(fruitsGame.extractEmojis())", destination: EmojiMemoryGameView(game: fruitsGame))
                    .padding(.top)
                NavigationLink("\(sportsGame.name): \(sportsGame.extractEmojis())", destination: EmojiMemoryGameView(game: sportsGame))
                    .padding(.top)
                NavigationLink("\(girlsGame.name): \(girlsGame.extractEmojis())", destination: EmojiMemoryGameView(game: girlsGame))
                    .padding(.top)
                NavigationLink("\(boysGame.name): \(boysGame.extractEmojis())", destination: EmojiMemoryGameView(game: boysGame))
                    .padding(.top)
                NavigationLink("\(animalsGame.name): \(animalsGame.extractEmojis())", destination: EmojiMemoryGameView(game: animalsGame))
                    .padding(.top)
                Spacer()
            }
            .padding(.vertical)
        }
    }
}

struct ThemeChoose_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChoose()
    }
}
