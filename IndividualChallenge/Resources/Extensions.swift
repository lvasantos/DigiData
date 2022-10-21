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

    func pin(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
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

extension UIImage {
    func scaleImage(targetSize: CGSize) -> UIImage {
        let widthRatio = targetSize.width / self.size.width
        let heightRatio = targetSize.height / self.size.height

        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: self.size.width * heightRatio, height: self.size.height * heightRatio)
        } else {
            newSize = CGSize(width: self.size.width * widthRatio, height: self.size.height * widthRatio)
        }
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let scaledImage = newImage else {
            return UIImage(named: "questionmark")!
        }

        return scaledImage
    }

}
