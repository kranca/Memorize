//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Raúl Carrancá on 01/03/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                Spacer()
                bottomBody
            }
            deckBody
                .padding(.bottom, DrawingConstants.deckPadding)
        }
    }
    
    @State private var dealt = Set<UUID>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (DrawingConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: DrawingConstants.dealDuration).delay(delay)
    }
    
    // inverts cards order when stacked on top of each other, otherwise botom card is dealt first
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var gameBody: some View {
        VStack {
            Text("\(game.name) theme!")
                .font(.headline)
                .bold()

            AspectRatioVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                // this code is not a View, it's ViewBuilder syntax. For it to work we need @ViewBuilder in ARVG
                if isUndealt(card) || card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .padding(4)
                        // transition animation
                        //.transition(AnyTransition.scale.animation(.easeInOut))
                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale).animation(.easeInOut))
                        // Controls the display order of overlapping views
                        .zIndex(zIndex(of: card))
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                game.choose(card)
                            }
                        }
                }
            })
            .padding(.horizontal)
            //.foregroundColor(game.selectColor())
            .foregroundColor(game.getThemeColor())
        }
    }
    
    var deckBody: some View {
        ZStack {
            // same as 'ForEach(game.cards.filter { isUndealt($0) }) { card in', since filter is a func
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: DrawingConstants.undealtWidth, height: DrawingConstants.undealtHeight)
        .foregroundColor(game.getThemeColor())
        .onTapGesture {
            // deal cards animation
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var bottomBody: some View {
        HStack {
            Button(action: {
                self.game.startNewGame()
                // explicit animation -> this kind of animation is mostly used with user intents
                withAnimation {
                    game.shuffle()
                }
            }, label: {
                VStack {
                    Image(systemName: "plus.rectangle")
                    Text("New Game")
                }
            })
            Spacer()
            Button("Restart") {
                withAnimation {
                    dealt = []
                    game.restart()
                }
            }
            Spacer()
            Button("Shuffle") {
                withAnimation {
                    game.shuffle()
                }
            }
            Spacer()
            Text("Score: \(game.getScore())")
        }.padding(.horizontal)
    }
    
    private struct DrawingConstants {
        static let aspectRatio: CGFloat = 2/3
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
        static let dealDuration: Double = 1
        static let totalDealDuration: Double = 3
        static let deckPadding: CGFloat = 30
    }
}

//struct EmojiMemoryGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = EmojiMemoryGame(theme: EmojiMemoryGame.vehiclesTheme)
//        EmojiMemoryGameView(game: game)
//    }
//}
