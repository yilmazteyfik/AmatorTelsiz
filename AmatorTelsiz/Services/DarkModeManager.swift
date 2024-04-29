//
//  DarkModeManager.swift
//  AmatorTelsiz
//
//  Created by Melik Bilyay on 29.04.2024.
//

import Foundation

import UIKit

class DarkModeManager {
    static let shared = DarkModeManager()
    
    var isDarkModeEnabled = false {
        didSet {
            if isDarkModeEnabled {
                applyDarkMode()
            } else {
                revertToOriginalColors()
            }
        }
    }
    
    private func applyDarkMode() {
        // Burada dark mode renklerini ayarla
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
    }
    
    private func revertToOriginalColors() {
        // Burada eski renklere geri dön
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
    }
}
