//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        //создаем кривые на сцене
        createBezier(on: view)
    }
    
    private func createBezier(on view: UIView) {
        //1 создаем графический контекст (слой)
        //на нем в дальнейшем будут рисоваться кривые
        let shapeLayer = CAShapeLayer()
        //2 добавляем слой в качестве дочернего к корневому слою корневого представления
        view.layer.addSublayer(shapeLayer)
        
        // измненение цвета линий
        shapeLayer.strokeColor = UIColor.gray.cgColor
        //изменение толщины линий
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.green.cgColor
        //стиль окончания линии
        shapeLayer.lineCap = .round
        // принимает массив из пары значений которые определяют размер прерывания и размер прерывистой линой
        shapeLayer.lineDashPattern = nil
        //определяет где начинается фигура и заканчивается от 0 до 1
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        // определяет стиль соединительный точек
        shapeLayer.lineJoin = .bevel
        
        //3 создание фигуры
        //shapeLayer.path = getPath().cgPath
        //shapeLayer.path = getRect().cgPath
        //shapeLayer.path = getArc().cgPath
        //shapeLayer.path = getCurve().cgPath
        shapeLayer.path = getChefsHat().cgPath
    }
    
    private func getPath() -> UIBezierPath {
        //создание первого треугольника
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 50, y: 50))
        path.addLine(to: CGPoint(x: 150, y: 50))
        //cоздание второй линии
        path.addLine(to: CGPoint(x: 150, y: 150))
        //создание третьей линии с помощью завершения фигуры
        path.close()
        
        //создание второго треугольника
        path.move(to: CGPoint(x: 50, y: 70))
        path.addLine(to: CGPoint(x: 150, y: 170))
        path.addLine(to: CGPoint(x: 50, y: 170))
        path.close()
        
        return path
    }
    
    private func getRect() -> UIBezierPath {
        //создание сущности прямоугольник
        let rect = CGRect(x: 10, y: 10, width: 200, height: 100)
        //создание прямоугольника
        //let path = UIBezierPath(roundedRect: rect, cornerRadius: 30)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomRight, .topLeft], cornerRadii: CGSize(width: 30, height: 0))
        
        return path
    }
    
    private func getArc() -> UIBezierPath {
        //let centerPoint = CGPoint(x: 200, y: 200)
       // //let path = UIBezierPath(arcCenter: centerPoint, radius: 150, startAngle: .pi/5, endAngle: .pi, clockwise: true)
        let rect = CGRect(x: 50, y: 50, width: 200, height: 100)
        let path = UIBezierPath(ovalIn: rect)
        return path
    }
    
    private func getCurve() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 10))
        path.addCurve(to: CGPoint(x: 200, y: 200), controlPoint1: CGPoint(x: 200, y: 20), controlPoint2: CGPoint(x: 20, y: 200))
        return path
    }
    
    private func getChefsHat() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 100))
        path.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 50, startAngle: .pi, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: 220, y: 100))
        path.addArc(withCenter: CGPoint(x: 220, y: 150), radius: 50, startAngle: .pi*3/2, endAngle: .pi/2, clockwise: true)
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 200, y: 260))
        path.addLine(to: CGPoint(x: 100, y: 260))
        path.addLine(to: CGPoint(x: 100, y: 200))
        path.addLine(to: CGPoint(x: 80, y: 200))
        path.addArc(withCenter: CGPoint(x: 80, y: 150), radius: 50, startAngle: .pi/2, endAngle: .pi*3/2, clockwise: true)
        path.close()
        return path
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
