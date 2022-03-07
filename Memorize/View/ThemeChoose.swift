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
                NavigationLink("\(vehicleGame.name): \(vehicleGame.extractEmojis())", destination: ContentView(viewModel: vehicleGame))
                    .padding(.top)
                NavigationLink("\(fruitsGame.name): \(fruitsGame.extractEmojis())", destination: ContentView(viewModel: fruitsGame))
                    .padding(.top)
                NavigationLink("\(sportsGame.name): \(sportsGame.extractEmojis())", destination: ContentView(viewModel: sportsGame))
                    .padding(.top)
                NavigationLink("\(girlsGame.name): \(girlsGame.extractEmojis())", destination: ContentView(viewModel: girlsGame))
                    .padding(.top)
                NavigationLink("\(boysGame.name): \(boysGame.extractEmojis())", destination: ContentView(viewModel: boysGame))
                    .padding(.top)
                NavigationLink("\(animalsGame.name): \(animalsGame.extractEmojis())", destination: ContentView(viewModel: animalsGame))
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
