//
//  Extension.swift
//  Gungunaoo
//
//  Created by Keyur Panchal on 06/08/22.
//

import UIKit

extension UIView {
    func addGradient() {
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.837, green: 0.937, blue: 1, alpha: 1).cgColor,
          UIColor(red: 0.351, green: 0.62, blue: 0.679, alpha: 1).cgColor,
          UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]
        layer0.locations = [0, 0.55, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.95, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.18, b: 0.92, c: -0.92, d: 0.25, tx: 0.35, ty: -0.07))
        layer0.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
        layer0.position = self.center
        self.layer.insertSublayer(layer0, at: 0)
    }
}

extension UIStoryboard {
    func instantiateVC<T: UIViewController>(withIdentifier id: T.Type) -> T {
        guard let controller = self.instantiateViewController(withIdentifier: String(describing: id)) as? T else {
            fatalError("could not cast UIViewController")
        }
        return controller
    }
}

extension UIViewController {
    func pushVC(_ controller: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(controller, animated: animated)
    }
}
