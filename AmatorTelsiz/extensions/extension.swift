//
//  extension.swift
//  AmatorTelsiz
//
//  Created by Teyfik Yılmaz on 16.06.2024.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xff0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0xff00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
