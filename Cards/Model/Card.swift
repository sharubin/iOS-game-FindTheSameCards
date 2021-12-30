//
//  Card.swift
//  Cards
//
//  Created by Artsem Sharubin on 25.12.2021.
//

import Foundation
import UIKit

// типы фигуры карт
enum CardType: CaseIterable {
    case cirle
    case cross
    case square
    case fill
}

//цвета карт
enum CardColor: CaseIterable {
    case red
    case green
    case black
    case gray
    case brown
    case yellow
    case purple
    case orange
}

typealias Card = (type: CardType, color: CardColor)
