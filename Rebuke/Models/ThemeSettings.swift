//
//  ThemeSettings.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 8/25/22.
//

import SwiftUI

//JWD:  ThemeClass

class ThemeSettings: ObservableObject {
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
    init() {}
    public static let shared = ThemeSettings()
}
