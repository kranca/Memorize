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
    @State private var editing = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(game: vehicleGame), label: {
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(theme.name)
                                    Text("Pairs: \(theme.cardPairs)")
                                }
                                RoundedRectangle(cornerRadius: 5)
                                    .size(width: 30, height: 45)
                                    .fill()
                                    .foregroundColor(Color(rgbaColor: theme.rgbaColor))
                                    //.aspectRatio(2/3, contentMode: .fill)
                            }
                            Text(theme.emojis)
                        }
                        .gesture(editMode == .active ? tap(on: store.themes.firstIndex(of: theme) ?? 0) : nil)
                    })
                }
                .onDelete(perform: { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                })
                .onMove(perform: { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                })
            }
            .navigationTitle("Choose a theme!")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { editMode == .active ? newThemeButton : nil }
                ToolbarItem { EditButton() }
            }
            .sheet(isPresented: $editing) {
                ThemeEditor(theme: $store.themes[chosenThemeIndex])
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    @State private var chosenThemeIndex: Int = 0
    
    func tap(on tapedThemeIndex: Int) -> some Gesture {
        TapGesture().onEnded {
            chosenThemeIndex = tapedThemeIndex
            editing = true
        }
    }
    
    private var newThemeButton: some View {
        Button("Add New Theme") {
            chosenThemeIndex = 0
            store.insertTheme(named: "", cardPairs: 2)
            editing = true
        }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
    }
}
