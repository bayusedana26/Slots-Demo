//
//  ContentView.swift
//  Slots Demo
//
//  Created by Bayu Sedana on 28/11/22.
//

import SwiftUI

struct ContentView: View {
    private var betAmount = 5
    @State private var symbols = ["apple", "cherry", "star"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var credits = 1000
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255)).edgesIgnoringSafeArea(.all)
            
            Rectangle().foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255)).rotationEffect(Angle(degrees: 45)).edgesIgnoringSafeArea(.all)
            
            VStack {
                // MARK: title
                HStack {
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text("SwiftUI Slots!")
                        .foregroundColor(.white)
                        .bold()
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }
                .scaleEffect(2)
                
                Spacer()
                
                // MARK: credit counter
                Text("Credit points: " + String(credits))
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(25)
                
                Spacer()
                
                VStack {
                    HStack {
                        // MARK: change images
                        CardView(symbol: $symbols[numbers[0]],
                                 background: $backgrounds[0])
                        CardView(symbol: $symbols[numbers[1]],
                                 background: $backgrounds[1])
                        CardView(symbol: $symbols[numbers[2]],
                                 background: $backgrounds[2])
                    }
                    HStack {
                        // MARK: change images
                        CardView(symbol: $symbols[numbers[3]],
                                 background: $backgrounds[3])
                        CardView(symbol: $symbols[numbers[4]],
                                 background: $backgrounds[4])
                        CardView(symbol: $symbols[numbers[5]],
                                 background: $backgrounds[5])
                    }
                    HStack {
                        // MARK: change images
                        CardView(symbol: $symbols[numbers[6]],
                                 background: $backgrounds[6])
                        CardView(symbol: $symbols[numbers[7]],
                                 background: $backgrounds[7])
                        CardView(symbol: $symbols[numbers[8]],
                                 background: $backgrounds[8])
                    }
                }
                
                Spacer()
                
                
                // MARK: button action
                HStack (spacing: 25)
                {
                    VStack {
                        // MARK: single spin
                        Button(action: {
                            self.processResult()
                        })
                        {
                            Text("Spin")
                                .padding(.all, 10)
                                .padding(.horizontal, 30)
                                .bold()
                                .foregroundColor(.white)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount) credits")
                            .padding(.top, 10.0)
                            .font(.footnote)
                    }
                    VStack {
                        
                        // MARK: max spin
                        Button(action: {
                            self.processResult(true)
                        })
                        {
                            Text("Max Spin")
                                .padding(.all, 10)
                                .padding(.horizontal, 30)
                                .bold()
                                .foregroundColor(.white)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount * 5) credits")
                            .padding(.top, 10.0)
                            .font(.footnote)
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    func processResult(_ isMax:Bool = false) {
        
        // MARK: set default bg to white
        self.backgrounds = self.backgrounds.map({_ in Color.white})
        
        // MARK: spin cards
        if isMax {
            // MARK: spin all cards
            self.numbers = self.numbers.map({
                _ in Int.random(in: 0...self.symbols.count - 1)
            })
        } else {
            // MARK: spin middle row
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
        }
        
        // MARK: check winnings
        processMaxSpin(isMax)
    }
    func processMaxSpin(_ isMax:Bool = false) {
        
        var matches = 0
        
        // MARK: check win and lose condition middle row
        if !isMax {
            if isMatches(3, 4, 5) {matches += 1}
        }
        
        // MARK: check win and lose condition max spin
        else {
            // MARK: top row
            if isMatches(0, 1, 2) {matches += 1}
            
            //MARK: middle row
            if isMatches(3, 4, 5) {matches += 1}
            
            //MARK: bottom row
            if isMatches(6, 7, 8) {matches += 1}

            //MARK: diagonal top left to bottom right
            if isMatches(0, 4, 8) {matches += 1}
            
            //MARK: diagonal top right to bottom left
            if isMatches(2, 4, 6) {matches += 1}
        }
            // MARK: check matches and distribute credits
            if matches > 0 {
                // At least 1 win
                self.credits += matches * betAmount * 2
            } else if !isMax {
                // 0 wins, single spin
                self.credits -= betAmount
            } else {
                // 0 wins, max spin
                self.credits -= betAmount * 5
            }
        }
    func isMatches(_ index1: Int, _ index2: Int, _ index3: Int) -> Bool {
        
        if self.numbers[index1] == self.numbers[index2] && self.numbers[2] == self.numbers[3] {
            
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green

            return true
        }
        return false
            }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
