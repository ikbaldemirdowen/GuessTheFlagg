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
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...4)
    @State private var score = 0
    @State private var dismiss = false

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
                }
            
                ForEach(0..<5)
                {
                    number in
                    Button
                    {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(Capsule())
                            .shadow(radius: 100)
                    }
                }
                Spacer()
                VStack
                {
                    Button("Reset!")
                    {
                        askQuestion()
                        score = 0
                    }
                    .foregroundColor(.black)
                }
                Spacer()
            }
//            .frame(maxWidth: .infinity)
//            .background(.ultraThinMaterial)
//            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .alert(scoreTitle, isPresented: $showingScore)
        {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score) now")
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
            scoreTitle = "Wrong!"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion()
    {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...4)
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
