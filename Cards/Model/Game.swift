//
//  Game.swift
//  Cards
//
//  Created by Artsem Sharubin on 25.12.2021.
//

import Foundation

class Game {
    //колличество пар уникальных карточек
    var cardsCount = 0
    //массив сгенерированных карточек
    var cards = [Card]()
    
    //генерация массива случайных карт
    func generateCards() {
        //генериурем новый массив карточек
        var cards = [Card]()
        for _ in 0...cardsCount {
            let randomElement = (type: CardType.allCases.randomElement()!, color: CardColor.allCases.randomElement()!)
            cards.append(randomElement)
        }
        self.cards = cards
    }
    
    //проверка эквивалентности карточек
    func checkCards(_ firstCard: Card, _ secondCard: Card) -> Bool {
        firstCard == secondCard
    }
    
}
