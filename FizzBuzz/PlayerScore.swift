//
//  PlayerScore.swift
//  FizzBuzz
//
//  Created by Benjamin Yeager on 3/19/24.
//

import Foundation

struct PlayerScore: Codable, Identifiable
{
    var name : String
    var score : Int
    var id: String = UUID().uuidString
}
