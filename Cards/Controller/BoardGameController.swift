//
//  BoardGameController.swift
//  Cards
//
//  Created by Artsem Sharubin on 25.12.2021.
//

import UIKit

class BoardGameController: UIViewController {
    override func loadView() {
        super.loadView()
        
        //добавляем кнопку на сцену
        view.addSubview(startButtonView)
        //добавляем игровое поле на сцену
        view.addSubview(boardGameView)
    }
    
    //колличество пар уникальных карточек
    var cardsPairsCounts = 8
    // сущность игра
    lazy var game: Game = getNewGame()
    
    private func getNewGame() -> Game {
        let game = Game()
        game.cardsCount = self.cardsPairsCounts
        game.generateCards()
        return game
    }
    
    //кнопка для запуска/перезапуска игры
    lazy var startButtonView = getStartButtonView()
    
    private func getStartButtonView() -> UIButton {
        //1 создаем кнопку
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        //2изменяем положение кнопки
        button.center.x = view.center.x
        
        //получаем доступ к текущему окну
        let window = UIApplication.shared.windows[0]
        //определяем отступ сверху от границ окна до safe area
        let topPadding = window.safeAreaInsets.top
        //устанавливаем координату y кнопки в соответсвии с отступом
        button.frame.origin.y = topPadding
        
        //3настраиваем внешний вид кнопки
        //устанавливаем текст
        button.setTitle("Начать игру", for: .normal)
        //устанавливаем цвет текста для не нажатаго состояния
        button.setTitleColor(.black, for: .normal)
        //устанавливаем цвет текста для нажатого состояния
        button.setTitleColor(.gray, for: .highlighted)
        //устанавливаем фоновый цвет
        button.backgroundColor = .systemGray4
        //скругляем углы
        button.layer.cornerRadius = 10
        
        //подключаем обработчик нажатия на кнопку
        button.addTarget(nil, action: #selector(startGame(_:)), for: .touchUpInside)
        
        return button
    }
    
    @objc func startGame(_ sender: UIButton) {
        game = getNewGame()
        let cards = getCardsBy(modelData: game.cards)
        placeCardsOnBoard(cards)
    }
    
    //игровое поле
    lazy var boardGameView = getBoardGameView()
    
    private func getBoardGameView() -> UIView {
        //отступ игрового поля от от ближайших элементов
        let margin: CGFloat = 10
        
        let boardView = UIView()
        //указываем координаты х
        boardView.frame.origin.x = margin
        //указываем координаты y
        let window = UIApplication.shared.windows[0]
        let topPading = window.safeAreaInsets.top
        boardView.frame.origin.y = topPading + startButtonView.frame.height + margin
        
        //рассчитываем ширину
        boardView.frame.size.width = UIScreen.main.bounds.width - margin*2
        //рассчитываем высоту с учетом нижнего отступа
        let bottomPadding = window.safeAreaInsets.bottom
        boardView.frame.size.height = UIScreen.main.bounds.height - boardView.frame.origin.y - margin - bottomPadding
        
        //изменяем стиль игрового поля
        boardView.layer.cornerRadius = 5
        boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3)
        
        return boardView
    }
    
    //генерация массива карточек на основе данных модели
    private func getCardsBy(modelData: [Card]) -> [UIView] {
        //хранилище для представлений карточек
        var cardViews = [UIView]()
        //фабрика карточек
        let cardViewFactory = CardViewFactory()
        //перебираем массив карточек в модели
        for (index, modelCard) in modelData.enumerated() {
            //добавляем новый экземпляр карты
            let cardOne = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardOne.tag = index
            cardViews.append(cardOne)
            
            //добавляем второй экземпляр карты
            let cardTwo = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardTwo.tag = index
            cardViews.append(cardTwo)
        }
        //добавляем всем карточкам обработчик переворота
        for card in cardViews {
            (card as! FlippableView).flipCompletionHandler = {flippedCard in
                //переносим карточку вверху иерархии
                flippedCard.superview?.bringSubviewToFront(flippedCard)
                
                //добавляем или удаляем карточку
                if flippedCard.isFlipped {
                    self.flippedCards.append(flippedCard)
                } else {
                    if let cardIndex = self.flippedCards.firstIndex(of: flippedCard) {
                        self.flippedCards.remove(at: cardIndex)
                    }
                }
                
                //если перевернуто 2 карточки
                if self.flippedCards.count == 2 {
                    //получаем карточки из данных модели
                    let firstCard = self.game.cards[self.flippedCards.first!.tag]
                    let secondCard = self.game.cards[self.flippedCards.last!.tag]
                    
                    //если карточки одинаковые
                    if self.game.checkCards(firstCard, secondCard) {
                        //сперва анимировано скрываем их
                        UIView.animate(withDuration: 0.3, animations: {self.flippedCards.first!.layer.opacity = 0
                            self.flippedCards.last!.layer.opacity = 0
                            //после чего удаляем из иерархии
                        }, completion: {_ in
                            self.flippedCards.first!.removeFromSuperview()
                            self.flippedCards.last!.removeFromSuperview()
                            self.flippedCards = []
                        })
                        //в ином случае
                    } else {
                        //переворачиваем карточки рабушкой вверх
                        for card in self.flippedCards {
                            (card as! FlippableView).flip()
                        }
                    }
                }
            }
        }
        return cardViews
    }
    
    private var cardSize: CGSize {
        CGSize(width: 80, height: 120)
    }
    
    //предельные координаты размещения карточки
    private var cardMaxXCoordinate: Int {
        Int(boardGameView.frame.width - cardSize.width)
    }
    private var cardMaxYCoordinate: Int {
        Int(boardGameView.frame.height - cardSize.height)
    }
    
    //игральные карточки
    var cardViews = [UIView]()
    
    private func placeCardsOnBoard(_ cards: [UIView]) {
        //удаляем все имеющиеся на игровом поле карточки
        for card in cardViews {
            card.removeFromSuperview()
        }
        cardViews = cards
        //перебираем карточки
        for card in cardViews {
            // для каждой карточки генерируем случайные координаты
            let randomXCoordinate = Int.random(in: 0...cardMaxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...cardMaxYCoordinate)
            card.frame.origin = CGPoint(x: randomXCoordinate, y: randomYCoordinate)
            //размещаем карточку на игровом поле
            boardGameView.addSubview(card)
        }
    }
    
    private var flippedCards = [UIView]()
}
