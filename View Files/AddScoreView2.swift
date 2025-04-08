
import SwiftUI

struct AddScoreView2: View {
    @EnvironmentObject private var gameManager: GameManager
    @Environment(\.presentationMode) var presentationMode
    let playerIndex: Int
    @State private var score = ""
    
    var body: some View {
        NavigationView {
            Form {
                if let game = gameManager.currentGame, playerIndex < game.players.count {
                    Section(header: Text("Add Score for \(game.players[playerIndex].name)")) {
                        TextField("Score", text: $score)
                            .keyboardType(.numberPad)
                    }
                }
            }
            .navigationTitle("Add Score")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
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
