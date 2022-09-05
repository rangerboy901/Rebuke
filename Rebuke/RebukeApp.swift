//
//  RebukeApp.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 8/24/22.
//

import SwiftUI

@main
struct RebukeApp: App {
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    var body: some Scene {
        WindowGroup {
            WorkoutListScreen()
        }
    }
}
