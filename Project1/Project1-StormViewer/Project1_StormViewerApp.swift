//
//  Project1_StormViewerApp.swift
//  Project1-StormViewer
//
//  Created by Maximus Dionyssopoulos on 15/7/2023.
//

import SwiftUI

@main
struct Project1_StormViewerApp: App {
    var body: some Scene {
        Window("Storm Viewer", id:"main") {
            ContentView()
                .onAppear() {
                    NSWindow.allowsAutomaticWindowTabbing = false
                }
        }
        .commands {
            CommandGroup(replacing: .newItem) {}
            CommandGroup(replacing: .undoRedo) {}
            CommandGroup(replacing: .pasteboard) {}
        }
    }
}
