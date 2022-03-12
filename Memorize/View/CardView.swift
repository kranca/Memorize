//
//  CardView.swift
//  Memorize
//
//  Created by Raúl Carrancá on 10/03/22.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    // state var helps pie animation be redrawn constantly, instead of only when the card is flipped
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                // padding and opacity are in this way applied to both card options, with an without bonus time remaining
                Group {
                    if card.isConsumingBonusTime {
                        // Shapes origin coordinates start at the upper left corner, x increases to the right and y increases downwards, therefore 90º are deducted from the angle
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1 - animatedBonusRemaining) * 360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining) * 360-90))
                    }
                }
                .padding(DrawingConstants.piePadding)
                .opacity(DrawingConstants.pieOpacity)
                    Text(card.content)
                        // implicit animation
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
