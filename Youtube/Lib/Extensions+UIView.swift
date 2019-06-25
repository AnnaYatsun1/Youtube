//
//  UIView.swift
//  Youtube
//
//  Created by Anna Yatsun on 04/04/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
//
//extension UIView {
//    func addConstrainsWithFormat(format: String, views: UIView...) {
//        var viewDictionary = [String: UIView]()
//        for (index, view) in views.enumerated() {
//            let key = "v\(index)"
//            viewDictionary[key] = view
//        }
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
//    }
//}


extension UIImage {
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
