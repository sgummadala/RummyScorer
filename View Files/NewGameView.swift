
import SwiftUI

struct NewGameView: View {
    @EnvironmentObject private var gameManager: GameManager
    @State private var players: [String] = ["", ""]
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("New Rummy Game")
                .font(.largeTitle)
                .padding()
            
            Form {
                Section(header: Text("Players")) {
                    ForEach(0..<players.count, id: \.self) { index in
                        TextField("Player \(index + 1)", text: $players[index])
                    }
                    
                    Button(action: {
                        players.append("")
                    }) {
                        Label("Add Player", systemImage: "person.badge.plus")
                    }
                }
                
                if players.count > 2 {
                    Button(action: {
                        if !players.isEmpty {
                            players.removeLast()
                        }
                    }) {
                        Label("Remove Player", systemImage: "person.badge.minus")
                            .foregroundColor(.red)
                    }
                }
            }
            
            Button(action: startGame) {
                Text("Start Game")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Invalid Players"),
                    message: Text("Please enter a name for each player and have at least 2 players."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding()
    }
    
    private func startGame() {
        let validPlayers = players.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        
        if validPlayers.count >= 2 {
            let newPlayers = validPlayers.map { Player(name: $0) }
            gameManager.startNewGame(with: newPlayers)
        } else {
            showAlert = true
        }
    }
}
