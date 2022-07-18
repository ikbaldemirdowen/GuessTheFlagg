//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ikbal Demirdoven on 2022-07-13.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var questionCounter = 1
    @State private var showingResults = false
    var body: some View {
        ZStack
        {
            LinearGradient(colors: [.blue, .red], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            VStack
            {
                VStack
                {
                    Text("Guess The Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.black)
                    if score == 0
                    {
                        Text("Score is \(score) yet 🧐")
                            .foregroundColor(.black)
                            .bold()
                    }
                    else if score < 0
                    {
                        Text("Score is \(score) now 🙁")
                            .foregroundColor(.black)
                            .bold()
                    }
                    else
                    {
                        Text("Score is \(score) now 😎")
                            .foregroundColor(.black)
                            .bold()
                    }
                }
                
                .padding()
                .padding()
                
                VStack
                {
                    Text("Tag the flag of")
                        .foregroundColor(.black)
                        .font(.title2.weight(.bold))
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.black)
                        .font(.largeTitle.weight(.semibold))
                
            
                    ForEach(0..<3)
                    {
                        number in
                        Button
                        {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(Capsule())
                                .shadow(radius: 100)
                                .padding(10)
                        }
                    }
                }
                .padding(35)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding(25)
                Spacer()
                VStack
                {
                    Button("Reset!")
                    {
                        askQuestion()
                        score = 0
                        questionCounter = 0
                        showingResults = false
                        showingScore = false
                        countries = Self.allCountries.shuffled()
                        correctAnswer = Int.random(in: 0...2)
                    }
                    .foregroundColor(.black)
                }
                
                Spacer()
                
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore)
        {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score) now.")
        }
        .alert("Game Over!", isPresented: $showingResults)
        {
            Button("Start Again", action: newGame)
        } message: {
            Text("Your final score was \(score).")
        }
    }
    func flagTapped(_ number : Int)
    {
        if number == correctAnswer
        {
            scoreTitle = "Correct!"
            score += 1
        }
        else
        {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            if score > 0
            {
                score -= 1
            }
        }
        if questionCounter == 8
        {
            showingResults = true
        }
        else
        {
            showingScore = true
        }
    }
    
    func askQuestion()
    {
        countries.remove(at: correctAnswer)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }
    
    func newGame()
    {
        questionCounter = 0
        score = 0
        countries = Self.allCountries
        askQuestion()
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
