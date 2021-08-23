//
//  UIButton + Extension.swift
//  RxSwiftCourse
//
//  Created by Nurlan Akylbekov on 23.08.2021.
//

import UIKit

extension UIButton {
    
    convenience init(
        backgroundColor: UIColor,
        title: String,
        titleColor: UIColor,
        cornerRadius: CGFloat,
        borderWidth: CGFloat,
        borderColor: CGColor
    
    ) {
        self.init(type: .system)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
}
