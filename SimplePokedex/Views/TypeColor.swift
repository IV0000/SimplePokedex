//
//  CategoryEnum.swift
//  SimplePokedex
//
//  Created by Ivan Voloshchuk on 23/06/22.
//

import Foundation
import SwiftUI

enum TypeColor: String {
    case dark
    case normal
    case fight
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case electric
    case psychic
    case ice
    case dragon
    case fairy
    case grass
}

extension TypeColor: CaseIterable{
    var color: Color {
        switch self {
        case .dark:
            return Color(hex: 0x735B4E)
        case .normal:
            return Color(hex: 0xA9A87D)
        case .fight:
            return Color(hex: 0xB13E32)
        case .flying:
            return Color(hex: 0x9AA3DB)
        case .poison:
            return Color(hex: 0xB05F9C)
        case .ground:
            return Color(hex: 0xE3D5AD)
        case .rock:
            return Color(hex: 0xB9A971)
        case .bug:
            return Color(hex: 0xADBD56)
        case .ghost:
            return Color(hex: 0x6562AD)
        case .steel:
            return Color(hex: 0xAEACC3)
        case .fire:
            return Color(hex: 0xEA5740)
        case .water:
            return Color(hex: 0x4792EF)
        case .electric:
            return Color(hex: 0xF4C75F)
        case .psychic:
            return Color(hex: 0xED78A0)
        case .ice:
            return Color(hex: 0x70C9E1)
        case .dragon:
            return Color(hex: 0x8068E5)
        case .fairy:
            return Color(hex: 0xF2B9EE)
        case .grass:
            return Color(hex: 0x8CD577)
        }
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
