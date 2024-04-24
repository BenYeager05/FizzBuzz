//
//  highScoreView.swift
//  FizzBuzz
//
//  Created by Benjamin Yeager on 3/15/24.
//

import SwiftUI

struct highScoreView: View 
{
    @State var scores : [PlayerScore] = []

    var currentHighScore: Int {
        var maxScore = Int.min
        for score in scores
        {
            if score.score >= maxScore
            {
                maxScore = score.score
            }
        }
        // loop through all high scores and find the largest and return it
        return maxScore
    }
    
    
    var body: some View
    {
        VStack
        {
            
            Text("High Scores").font(.system(size: 42)).bold()
            Rectangle()
                .fill(.black)
                .frame(width: 390, height: 4)
            Spacer()
            VStack(alignment: .leading, content: 
            {
                Text("Current High Score: \(currentHighScore)").font(.system(size: 25))
                Rectangle()
                    .fill(.gray)
                    .frame(width: 390, height: 4)
                List {
                    ForEach(scores) {
                        score in
                        HStack {
                            Text("\(score.name)")
                            Spacer()
                            Text("\(score.score)")
                            
                        }
                        
                    }
                }
                .listStyle(.plain)
                Spacer()

            })
            
                
            }
        .onAppear(perform: {
            loadfromUserDefaults()
        })
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



#Preview
{
    highScoreView()
}
