//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Raúl Carrancá on 01/03/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
