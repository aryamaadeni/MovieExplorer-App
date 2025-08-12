//
//  AppStyles.swift
//  MovieExplorer
//
//  Created by Arya Maadeni on 12/08/25.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }

    static let appBackground = Color(hex: 0x12121E)
    static let appPrimary = Color(hex: 0xFFFFFF)
    static let appSecondary = Color(hex: 0x9E9E9E)
    static let appAccent = Color(hex: 0xFF5722)
    static let appCardBackground = Color(hex: 0x1E1E2A)
}

extension Font {
    static let titleFont = Font.system(size: 24, weight: .bold, design: .rounded)
    static let subtitleFont = Font.system(size: 18, weight: .semibold, design: .rounded)
    static let bodyFont = Font.system(size: 14, weight: .regular, design: .rounded)
    static let captionFont = Font.system(size: 12, weight: .regular, design: .rounded)
}
