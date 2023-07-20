//
//  CowsAndBullsApp.swift
//  CowsAndBulls
//
//  Created by Maximus Dionyssopoulos on 16/7/2023.
//

import SwiftUI

@main
struct CowsAndBullsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        
        Settings(content: SettingsView.init)
    }
}
