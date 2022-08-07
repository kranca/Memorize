//
//  Extensions.swift
//  Memorize
//
//  Created by Raúl Carrancá on 06/08/22.
//

import SwiftUI

extension Color {
    init(rgbaColor rgba: RGBAColor) {
        self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
    }
}

extension RGBAColor {
    init(color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        if let cgColor = color.cgColor {
            UIColor(cgColor: cgColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
}

extension Theme {
    init(name: String, color: Color, emojis: String, cardPairs: Int, id: Int) {
        self.name = name
        self.rgbaColor = RGBAColor(color: color)
        self.emojis = emojis
        self.cardPairs = cardPairs
        self.id = id
    }
}
