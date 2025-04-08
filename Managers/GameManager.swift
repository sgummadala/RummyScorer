//
//  GameManager.swift
//  RummyScorer
//
//  Created by SriramG on 4/7/25.
//

import Foundation
import SwiftUI



class GameManager: ObservableObject {
    @Published var currentGame: Game?
    @Published var gameHistory: [Game] = []
    
    init() {
        loadGames()
    }
 // update for roundscore start
    func updateCurrentGame(_ game: Game) {
        currentGame = game
        saveGames()
    }
//updated for roundscore end
    
    
    func startNewGame(with players: [Player]) {
        currentGame = Game(date: Date(), players: players)
        saveGames()
    }
    
    func addScore(for playerIndex: Int, score: Int) {
        guard var game = currentGame, playerIndex < game.players.count else {
            return
        }
        
        game.players[playerIndex].addScore(score)
        currentGame = game
        saveGames()
    }
    
    func completeCurrentGame() {
        guard var game = currentGame else { return }
        
        game.completeGame()
        gameHistory.append(game)
        currentGame = nil
        saveGames()
    }
    
    func deleteGame(at indexSet: IndexSet) {
        gameHistory.remove(atOffsets: indexSet)
        saveGames()
    }
    
    // MARK: - Persistence
    
    private func saveGames() {
        var allGames = gameHistory
        if let currentGame = currentGame {
            allGames.append(currentGame)
        }
        
        do {
            let data = try JSONEncoder().encode(allGames)
            UserDefaults.standard.set(data, forKey: "savedGames")
        } catch {
            print("Failed to save games: \(error)")
        }
    }
    
    private func loadGames() {
        guard let data = UserDefaults.standard.data(forKey: "savedGames") else {
            return
        }
        
        do {
            let allGames = try JSONDecoder().decode([Game].self, from: data)
            gameHistory = allGames.filter { $0.isComplete }
            currentGame = allGames.first { !$0.isComplete }
        } catch {
            print("Failed to load games: \(error)")
        }
    }
}



/*
// new roundscore update

func submitRoundScores(_ scores: [Int]) {
    guard var game = currentGame, scores.count == game.players.count else {
        return
    }
    
    // Add scores for each player
    for (index, score) in scores.enumerated() {
        game.players[index].addScore(score)
    }
    
    // Advance to next round
    game.currentRound += 1
    
    currentGame = game
    saveGames()
}
*/
