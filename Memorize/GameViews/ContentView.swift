//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Raúl Carrancá on 01/03/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var grid = [GridItem(.adaptive(minimum: 80))]
    var body: some View {
        VStack {
            Text("\(viewModel.name) theme!")
                .font(.headline)
                .bold()
            ScrollView {
                LazyVGrid(columns: grid) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
                .padding(.horizontal)
                .foregroundColor(viewModel.selectColor())
            }
            Spacer()
            HStack {
                Button(action: {
                    self.viewModel.startNewGame()
                }, label: {
                    VStack {
                        Image(systemName: "plus.rectangle")
                        Text("New Game")
                    }
                })
                Text("Score: \(viewModel.getScore())")
            }
        }
    }
    
   
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(theme: EmojiMemoryGame.vehiclesTheme)
        EmojiMemoryGameView(viewModel: game)
    }
}
