//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Raúl Carrancá on 07/08/22.
//

import SwiftUI

struct ThemeEditor: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var theme: Theme
    
    var body: some View {
        Form {
            nameSection
            cardPairsSection
            colorSection
            addEmojisSection
            removeEmojisSection
            closeButton
        }
        .navigationTitle("Edit \(theme.name)")
    }
    
    var nameSection: some View {
        Section(header: Text("Name"), content: {
            TextField("Name", text: $theme.name)
        })
    }
    
    var cardPairsSection: some View {
        Section(header: Text("Card Pairs"), content: {
            Stepper(value: $theme.cardPairs, in: 2...max(min(theme.emojis.count, 10), 2), step: 1) { //
                Text(String(theme.cardPairs))
            }
        })
    }
    
   var colorSection: some View {
        Section(header: Text("Color"), content: {
            ColorPicker("Chose a new color", selection: $theme.color)
        })
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis"), content: {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd, perform: { emojis in
                    addEmojis(emojis)
                })
        })
    }
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            theme.emojis = (emojis + theme.emojis)
                .filter( { $0.isEmoji })
                .removingDuplicateCharacters
        }
    }
    
    var removeEmojisSection: some View {
        Section(header: Text("Remove Emojis"), content: {
            let emojis = theme.emojis.removingDuplicateCharacters.map({
                String($0)
            })
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))], content: {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.removeAll(where: { String($0) == emoji})
                                if theme.cardPairs > theme.emojis.count {
                                    theme.cardPairs = theme.emojis.count
                                }
                            }
                        }
                }
            })
            .font(.system(size: 40))
        })
    }
    
    var closeButton: some View {
        Button(action: {
//            if UIDevice.current.userInterfaceIdiom != .pad {
//                presentationMode.wrappedValue.dismiss()
//            }
            if theme.canBePlayed {
                presentationMode.wrappedValue.dismiss()
            } else {
                insufficientEmojisAlert = true
            }
            
        }, label: {
            Text("Close")
        })
        .alert(isPresented: $insufficientEmojisAlert) {
            Alert(title: Text("Insufficient Emojis to play!"), message: Text("Please add at least 2 Emojis"), dismissButton: .cancel())
        }
    }
    
    @State var insufficientEmojisAlert = false
}

//struct ThemeManager_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeEditor()
//    }
//}
