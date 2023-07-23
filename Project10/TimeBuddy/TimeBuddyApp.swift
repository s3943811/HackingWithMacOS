//
//  TimeBuddyApp.swift
//  TimeBuddy
//
//  Created by Maximus Dionyssopoulos on 23/7/2023.
//

import SwiftUI

@main
struct TimeBuddyApp: App {
    var body: some Scene {
        MenuBarExtra {
            ContentView()
        } label: {
            Label("Time Buddy", systemImage: "person.badge.clock.fill")
        }
        .menuBarExtraStyle(.window)
    }
}
