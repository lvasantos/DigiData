//
//  Extensions.swift
//  IndividualChallenge
//
//  Created by Luciana Adrião on 13/10/22.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }

    var height: CGFloat {
        return frame.size.height
    }

    var left: CGFloat {
        return frame.origin.x
    }

    var top: CGFloat {
        return frame.origin.y
    }

    var right: CGFloat {
        return left + width
    }

    var bottom: CGFloat {
        return top + height
    }
}

// chamar como:
// view.addGradientWithColor(color: .red)
extension UIView {
    func addGradientWithColor(color: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color.cgColor, UIColor.black.cgColor]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 0.0, y: 0.8)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}

// chamar como:
//  let gradient = CAGradientLayer.makeWithColor(.red)
//  view.layer.addSublayer(gradient)
extension CAGradientLayer {
    static func makeWithColor(_ color: UIColor) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color.cgColor, UIColor.black.cgColor]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 0.0, y: 0.8)
        return gradient
    }
}
