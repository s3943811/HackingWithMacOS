//
//  SettingsView.swift
//  CowsAndBulls
//
//  Created by Maximus Dionyssopoulos on 16/7/2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            Form {
                TextField("Maximum Guesses", value: $maximumGuesses, format: .number)
                    .help("The maximum number of answers you can submit. Changing this will immediately restart your game.")
                TextField("Answer length", value: $answerLength, format: .number)
                    .help("The length of the number of string to guess. Changing this will immediately restart your game.")
                if answerLength < 3 || answerLength > 8 {
                    Text("Must be between 3 and 8")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .tabItem {
                Label("Game", systemImage: "number.circle")
            }
            
            Form {
                Toggle("Enable hard mode", isOn: $enableHardMode)
                    .help("This shows the cows and bulls score for only the most recent guess.")
                Toggle("Show guess count", isOn: $showGuessCount)
                    .help("Adds a footer below your guesses showing the total.")
            }
            .padding()
            .tabItem {
                Label("Advanced", systemImage: "gearshape.2")
            }
        }
        .frame(width: 400)
    }
    @AppStorage("maximumGuesses") var maximumGuesses = 100
    @AppStorage("answerLength") var answerLength = 4
    @AppStorage("enableHardMode") var enableHardMode = false
    @AppStorage("showGuessCount") var showGuessCount = false
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
