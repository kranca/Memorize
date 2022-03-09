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
                // this code is not a View, it's ViewBuilder syntax. For it to work we need @ViewBuilder in ARVG
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
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
                    // Shapes origin coordinates start at the upper left corner, x increases to the right and y increases downwards, therefore 90º are deducted from the angle
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 0.1-90))
                        .padding(DrawingConstants.piePadding).opacity(DrawingConstants.pieOpacity)
                    Text(card.content)
                        // direct animation
                        .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                        .animation(.easeIn)
                        // .font(font(in: geometry.size))
                        .font(.system(size: DrawingConstants.fontSize))
                        .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
            // without View extension in Cardify: .modifier(Cardify(isFaceUp: card.isFaceUp))
        })
    }
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontSize: CGFloat = 32
        static let fontScale: CGFloat = 0.75
        static let piePadding: CGFloat = 5
        static let pieOpacity: Double = 0.5
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(theme: EmojiMemoryGame.vehiclesTheme)
        EmojiMemoryGameView(game: game)
    }
}
