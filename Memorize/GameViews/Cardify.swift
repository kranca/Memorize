//
//  Cardify.swift
//  Memorize
//
//  Created by Raúl Carrancá on 09/03/22.
//

import SwiftUI


struct Cardify: AnimatableModifier { // was ViewModifier; conforms to both Animatable and ViewModifier
    var rotation: Double // in degrees
    
    // Animatable protocol requires animatableData and Double conforms
    // could use animatableData in if logic, but animatableData as a computed value works the same and provides better readability
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        self.rotation = isFaceUp ? 0 : 180
    }
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
