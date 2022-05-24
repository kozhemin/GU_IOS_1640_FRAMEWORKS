//
//  UITextField+Ext.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 23.05.2022.
//

import UIKit

extension UITextField {
    func appDefaultFieldStyle() {
        textColor = .black
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
}
