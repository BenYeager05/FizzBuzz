//
//  ContentView.swift
//  FizzBuzz
//
//  Created by Benjamin Yeager on 2/27/24.
//

import SwiftUI

struct ContentView: View 
{
    @State var counter = 0
    @State var userInput : String = ""
    @State var message = ""
    @State var answer = ""
    @State var color = Color.green
    @State var showAlert = false
    @FocusState var focusOntextField: Bool
    @State var playerScore : PlayerScore = PlayerScore(name: "Ben", score: 0)
    
    @State var scores : [PlayerScore] = []
    var body: some View
    {
        NavigationStack {
            
            
            VStack
            {
                Text("FizzBuzz").font(.system(size: 42)).bold()
                Rectangle()
                    .fill(.black)
                    .frame(width: 390, height: 4)
                Spacer()
                
                Text("Previous Number: \(counter)")
                
                Spacer()
                Text("\(userInput)").font(.system(size: 30)).textCase(.lowercase)
                    .frame(height: 100)
                
                TextField("Enter your answer", text: $userInput)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textCase(.lowercase)
                    .autocapitalization(.none)
                    .focused($focusOntextField)
                    .onSubmit {
                        counter += 1
                        checkAnswer()
                        userInput = ""
                        focusOntextField = true
                    }
                
                Button(action:
                        {
                    counter += 1
                    checkAnswer()
                    userInput = ""
                    
                }) {
                    Text("Submit")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                Spacer()
                Spacer()
                
                Text(message).font(.system(size: 42)).foregroundColor(color)
                
                Spacer()
                Spacer()
                
                
                
            }
            .alert(isPresented: $showAlert)
            {
                Alert(title: Text("Not correct"), message: Text("That is not correct you got to \(counter)"),  primaryButton: .default(Text("Play Again"), action:
                                                                                                                                        {
                    savedtoUserDefaults()
                    counter = 0
                    message = ""
                }),
                      secondaryButton: .cancel()
                      {
                        savedtoUserDefaults()
                        counter = 0
                        message = ""
                      }
                )
                
            }
            .padding()
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    NavigationLink(destination: highScoreView()) {
                        Image("highScoreIcon")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    
                }
            }
            .onAppear(perform: {
                loadfromUserDefaults()
            })

            
            
            
            
        }
    }
    
    
    func checkAnswer()
    {
        // Print the user's answer
        print("User's answer: \(userInput)")
        message = userInput
        if userInput != "fizz" || userInput != "buzz" || userInput != "fizzbuzz"
        {
            let stringConv = Int(userInput) ?? 0
        }
        if counter % 15 == 0
        {
            answer = "fizzbuzz"
        }
        else if counter % 3 == 0
        {
            answer = "fizz"
        }
       else if counter % 5 == 0
        {
            answer = "buzz"
        }
        else
        {
            answer = "\(counter)"
        }
        
        if userInput != answer
        {
            message = "Incorrect"
            showAlert = true
            color = Color.red
            
        }
        else
        {
            message = "Correct"
            color = Color.green
        }
    

        
    }
    
    func savedtoUserDefaults(){
        playerScore.score = counter
        scores.append(playerScore)
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(scores)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "scores")
            print ("saved Score")
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    func loadfromUserDefaults(){
        
        if let data = UserDefaults.standard.data(forKey: "scores") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                scores = try decoder.decode([PlayerScore].self, from: data)
                print(scores.count)
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
    }
}

#Preview {
    ContentView()
}
