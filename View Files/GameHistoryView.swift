
import SwiftUI

struct GameHistoryView: View {
    @EnvironmentObject private var gameManager: GameManager
    
    var body: some View {
        List {
            ForEach(gameManager.gameHistory) { game in
                NavigationLink(destination: GameDetailView(game: game)) {
                    VStack(alignment: .leading) {
                        Text(formatDate(game.date))
                            .font(.headline)
                        
                        if let winner = game.winner {
                            Text("Winner: \(winner.name) (\(winner.totalScore) points)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .onDelete(perform: gameManager.deleteGame)
        }
        .navigationTitle("Game History")
        .toolbar {
            EditButton()
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
