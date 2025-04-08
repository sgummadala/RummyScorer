//
//  Models.swift
//  RummyScorer
//
//  Created by SriramG on 4/7/25.
//
// Add this field to the Game struct if not already present

import SwiftUI
import Foundation
struct Game: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var players: [Player]
    var currentRound: Int = 0
    var isComplete: Bool = false
    var winner: Player?
    


    
    mutating func completeGame() {
        isComplete = true
        if let winningPlayer = players.min(by: { $0.totalScore < $1.totalScore }) {
            winner = winningPlayer
        }
    }
    
    // Add this method to the Game struct
    //
    mutating func advanceToNextRound() {
        currentRound += 1
    }
    
}

struct Player: Identifiable, Codable {
    var id = UUID()
    var name: String
    var totalScore: Int = 0
    var scores: [Int] = []
    
    mutating func addScore(_ score: Int) {
        scores.append(score)
        totalScore += score
    }
    
    mutating func removeLastScore() {
        if let lastScore = scores.popLast() {
            totalScore -= lastScore
        }
    }
}
