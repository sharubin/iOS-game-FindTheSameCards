//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport





class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        //игральная карточка номер 1
        let firstCardView = CardView<CircleShape>(frame: CGRect(x: 0, y: 0, width: 120, height: 150), color: .red)
        firstCardView.flipCompletionHandler = { card in
            card.superview?.bringSubviewToFront(card)
        }
        self.view.addSubview(firstCardView)
        
        //вторая игралбная карточка
        let secondCardView = CardView<CircleShape>(frame: CGRect(x: 200, y: 0, width: 120, height: 150), color: .red)
        secondCardView.isFlipped = true
        secondCardView.flipCompletionHandler = { card in
            card.superview?.bringSubviewToFront(card)
        }
        self.view.addSubview(secondCardView)
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
