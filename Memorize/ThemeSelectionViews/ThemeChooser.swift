//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Raúl Carrancá on 06/08/22.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: ThemeStore
    let vehicleGame = EmojiMemoryGame(theme: EmojiMemoryGame.vehiclesTheme)
    
    @State private var editMode: EditMode = .inactive
    @State private var name = "Raul"
    @State private var editing = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(game: vehicleGame), label: {
                        VStack {
                            Text(theme.name)
                            Text(theme.emojis)
                        }
                        .gesture(editMode == .active ? tap : nil)
                    })
                }
                .onDelete(perform: { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                })
                .onMove(perform: { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                })
            }
            .toolbar {
                EditButton()
            }
            .sheet(isPresented: $editing) {
                ThemeManager()
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    var tap: some Gesture {
        TapGesture().onEnded { editing = true }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
    }
}
