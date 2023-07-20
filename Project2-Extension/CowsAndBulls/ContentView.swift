//
//  ContentView.swift
//  CowsAndBulls
//
//  Created by Maximus Dionyssopoulos on 16/7/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("Enter a guess...", text: $guess)
                    .onSubmit {submitGuess()}
                Button("Go", action: submitGuess)
            }
            .padding()
            List(0..<guesses.count, id: \.self) { index in
                let guess = guesses[index]
                let shouldShowResult = (enableHardMode == false) || (enableHardMode && index == 0)
                
                let strResult = result(for: guess)
                
                let textColour: Color = !enableHardMode ? updateTextColour(with: strResult) : .primary
                    
                HStack {
                    Text(guess)
                    Spacer()
                    if shouldShowResult {
                        Text(strResult)
                            .foregroundColor(textColour)
                            .onChange(of: guesses.count) { newState in}
                    }
                }
            }
            .listStyle(.sidebar)
            if showGuessCount {
                Text("Guesses: \(guesses.count)/\(maximumGuesses)")
                    .padding()
            }
        }
        .frame(width: 250)
        .frame(minHeight: 300)
        .onAppear(perform: startNewGame)
        .onChange(of: answerLength) { _ in startNewGame() }
        .alert("You win", isPresented: $isGameOver) {
            Button("Ok", action: startNewGame)
        } message: {
            if guesses.count < 10 {
                Text("Congratulations, you won in \(guesses.count) moves! You are a skilled player. Click OK to play again.")
            }
            else if guesses.count < 20 {
                Text("Well done, you won in \(guesses.count) moves! You're nearly there. Click OK to play again.")
            }
            else {
                Text("You won in \(guesses.count) moves! You can do better. Click OK to play again.")
            }
        }
        .alert("You lose", isPresented: $isMaximumGuessReached) {
            Button("Ok", action: startNewGame)
        } message: {
            Text("You reached the maximum guess limit. The correct answer was \(answer), better luck next time. Click OK to play again.")
        }
        .navigationTitle("Cows and Bulls")
        .touchBar {
            HStack {
                Text("Guesses: \(guesses.count)")
                    .touchBarItemPrincipal()
                Spacer(minLength: 200)
            }
        }
    }
    
    @State private var guess = ""
    @State private var guesses = [String]()
    @State private var answer = ""
    @State private var isGameOver = false
    @State private var isMaximumGuessReached = false
    
    @AppStorage("maximumGuesses") var maximumGuesses = 100
    @AppStorage("answerLength") var answerLength = 4
    @AppStorage("enableHardMode") var enableHardMode = false
    @AppStorage("showGuessCount") var showGuessCount = false
    
    func submitGuess() {
        guard Set(guess).count == answerLength else { return }
        guard guess.count == answerLength else { return }
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guess.rangeOfCharacter(from: badCharacters) == nil else {return}
        guard guesses.doesNotContain(guess) else {return}
        
        guesses.insert(guess, at: 0)
        
        if result(for: guess).contains("\(answerLength)b") {
            isGameOver = true
        }
        if guesses.count == maximumGuesses {
            isMaximumGuessReached = true
        }
        guess = ""
    }
    func result(for guess: String) -> String {
        var bulls = 0
        var cows = 0
        let guessLetters = Array(guess)
        let answerLetters = Array(answer)
        for (index, letter) in guessLetters.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            }
            else if answerLetters.contains(letter) {
                cows += 1
            }
        }
        return "\(bulls)b \(cows)c"
    }
    func updateTextColour(with result: String) -> Color {
        let bulls = Int(result.dropLast(4)) ?? 0
        if bulls == 4 {
            return .green
        }
        let cows = Int(result.dropFirst(3).dropLast(1)) ?? 0
        let score = cows + bulls
        switch score {
        case 0:
            return .red
        case 1...3:
            return .yellow
        case 4:
            return .green
        default:
            return .primary
        }
    }
    func startNewGame() {
        guard answerLength >= 3 && answerLength <= 8 else { return }
        guess = ""
        guesses.removeAll()
        answer = ""
        let numbers = (0...9).shuffled()
        for i in 0..<answerLength {
            answer.append(String(numbers[i]))
        }
        print(answer)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



extension Array where Element: Equatable {
    func doesNotContain(_ element: Element) -> Bool {
        !contains(element)
    }
}
