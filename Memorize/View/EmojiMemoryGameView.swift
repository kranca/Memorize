//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Raúl Carrancá on 01/03/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
//    var grid = [GridItem(.adaptive(minimum: 80))]
    var body: some View {
        VStack {
            Text("\(game.name) theme!")
                .font(.headline)
                .bold()

            AspectRatioVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
                // this code is not a View, it's ViewBuilder syntax. For it to work we need @ViewBuilder in ARVG
//                if card.isMatched && !card.isFaceUp {
//                    Rectangle().opacity(0)
//                } else {
//                    CardView(card: card)
//                        .padding(4)
//                        .onTapGesture {
//                            game.choose(card)
//                        }
//                }
            })
            .padding(.horizontal)
            .foregroundColor(game.selectColor())

            Spacer()
            HStack {
                Button(action: {
                    self.game.startNewGame()
                }, label: {
                    VStack {
                        Image(systemName: "plus.rectangle")
                        Text("New Game")
                    }
                })
                Spacer()
                Text("Score: \(game.getScore())")
            }.padding(.horizontal)
        }
    }
    
   
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        })
    }
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(theme: EmojiMemoryGame.vehiclesTheme)
        EmojiMemoryGameView(game: game)
    }
}
