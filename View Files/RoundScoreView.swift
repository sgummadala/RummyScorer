
import SwiftUI

struct RoundScoreView: View {
    @EnvironmentObject private var gameManager: GameManager
    @Environment(\.presentationMode) var presentationMode
    
    // These will store the scores entered for each player
    @State private var playerScores: [String] = []
    
    var body: some View {
        NavigationView {
            Form {
                if let game = gameManager.currentGame {
                    Section(header: Text("Round \(game.currentRound + 1)")) {
                        ForEach(0..<game.players.count, id: \.self) { index in
                            HStack {
                                Text(game.players[index].name)
                                Spacer()
                                TextField("Score", text: getBindingForIndex(index))
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.trailing)
                                    .frame(width: 80)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Round Scores")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveRoundScores()
                }
            )
            .onAppear {
                // Initialize empty score fields for each player
                if let game = gameManager.currentGame {
                    playerScores = Array(repeating: "", count: game.players.count)
                }
            }
        }
    }
    
    // Helper function to safely get binding for an index
    private func getBindingForIndex(_ index: Int) -> Binding<String> {
        // Ensure we have enough elements in our array
        while playerScores.count <= index {
            playerScores.append("")
        }
        
        return Binding(
            get: { playerScores[index] },
            set: { playerScores[index] = $0 }
        )
    }
    
    private func saveRoundScores() {
        guard let game = gameManager.currentGame else { return }
        
        // Process each score
        for (index, scoreText) in playerScores.enumerated() {
            if index < game.players.count, let score = Int(scoreText) {
                // Add score to this player
                gameManager.addScore(for: index, score: score)
            }
        }
        
        // Advance to next round
        if var updatedGame = gameManager.currentGame {
            updatedGame.advanceToNextRound()
            gameManager.updateCurrentGame(updatedGame)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}
