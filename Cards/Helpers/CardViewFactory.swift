//
//  CardViewFactory.swift
//  Cards
//
//  Created by Artsem Sharubin on 26.12.2021.
//

import Foundation
import UIKit

class CardViewFactory {
    func get(_ shape: CardType, withSize size: CGSize, andColor color: CardColor) -> UIView {
        //на основе размеров определяем фрейм
        let frame = CGRect(origin: .zero, size: size)
        //определяем ui цвет на основе цвета модели
        let viewColor = getViewColorBy(modelColor: color)
        
        //генерируем и возвращаем карточку
        switch shape {
        case .cirle:
            return CardView<CircleShape>(frame: frame, color: viewColor)
        case .cross:
            return CardView<CrossShape>(frame: frame, color: viewColor)
        case .square:
            return CardView<SquareShape>(frame: frame, color: viewColor)
        case .fill:
            return CardView<FillShape>(frame: frame, color: viewColor)
        }
    }
    
    //преобразуем цвет модели в цвет представления
    private func getViewColorBy(modelColor: CardColor) -> UIColor {
        switch modelColor {
        case .red:
            return .red
        case .green:
            return .green
        case .black:
            return .black
        case .gray:
            return .gray
        case .brown:
            return .brown
        case .yellow:
            return .yellow
        case .purple:
            return .purple
        case .orange:
            return .orange
        }
    }
}
