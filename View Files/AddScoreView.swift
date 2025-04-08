//
//  AddScoreView-1.swift
//  RummyScorer
//
//  Created by SriramG on 4/12/25.
//

import SwiftUI

struct AddScoreView: View {
    @EnvironmentObject private var gameManager: GameManager
    @Environment(\.presentationMode) var presentationMode
    let playerIndex: Int
    @State private var score = ""
    
    var body: some View {
        NavigationView {
            Form {
                if let game = gameManager.currentGame, playerIndex < game.players.count {
                    Section {
                        // Display player name as a header
                        HStack {
                            Text(game.players[playerIndex].name)
                                .font(.headline)
                            Spacer()
                            Text("Round \(game.currentRound + 1)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                        
                        // Score entry with descriptive label
                        HStack {
                            Text("Enter score:")
                            Spacer()
                            TextField("Score", text: $score)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 100)
                        }
                    }
                    
                    // Player's current stats for reference
                    Section(header: Text("Current Stats")) {
                        HStack {
                            Text("Total Score")
                            Spacer()
                            Text("\(game.players[playerIndex].totalScore)")
                                .bold()
                        }
                        
                        if !game.players[playerIndex].scores.isEmpty {
                            HStack {
                                Text("Previous Round")
                                Spacer()
                                Text("\(game.players[playerIndex].scores.last ?? 0)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Score")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Submit") {
                    if let scoreValue = Int(score) {
                        gameManager.addScore(for: playerIndex, score: scoreValue)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .disabled(score.isEmpty)
            )
        }
    }
}
