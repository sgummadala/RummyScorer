
//--new one round score not workingArena
/*
import SwiftUI

struct CurrentGameView: View {
    @EnvironmentObject private var gameManager: GameManager
    @State private var showingScoreSheet = false
    @State private var showingIndividualScoreSheet = false
    @State private var selectedPlayerIndex = 0
    @State private var showEndGameAlert = false
    
    var body: some View {
        VStack {
            if let game = gameManager.currentGame {
                Text("Round \(game.currentRound + 1)")
                    .font(.headline)
                    .padding()
                
                List {
                    ForEach(0..<game.players.count, id: \.self) { index in
                        let player = game.players[index]
                        HStack {
                            Text(player.name)
                                .font(.title3)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Total: \(player.totalScore)")
                                    .font(.headline)
                                
                                if !player.scores.isEmpty {
                                    Text("Last: \(player.scores.last ?? 0)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Button(action: {
                                selectedPlayerIndex = index
                                showingIndividualScoreSheet = true
                            }) {
                                Image(systemName: "pencil.circle")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        showingScoreSheet = true
                    }) {
                        Text("Submit Round Scores")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        showEndGameAlert = true
                    }) {
                        Text("End Game")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .alert(isPresented: $showEndGameAlert) {
                    Alert(
                        title: Text("End Game"),
                        message: Text("Are you sure you want to end this game?"),
                        primaryButton: .destructive(Text("End Game")) {
                            gameManager.completeCurrentGame()
                        },
                        secondaryButton: .cancel()
                    )
                }
            } else {
                Text("No active game")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("RummyScorer")
        .sheet(isPresented: $showingScoreSheet) {
            RoundScoreView()
        }
        .sheet(isPresented: $showingIndividualScoreSheet) {
            AddScoreView(playerIndex: selectedPlayerIndex)
        }
    }

 */

/*
  //old code working without roundscore
import SwiftUI

struct CurrentGameView: View {
    @EnvironmentObject private var gameManager: GameManager
    @State private var showingScoreSheet = false
    @State private var selectedPlayerIndex = 0
    @State private var showEndGameAlert = false
    
    var body: some View {
        VStack {
            if let game = gameManager.currentGame {
                Text("Round \(game.currentRound + 1)")
                    .font(.headline)
                    .padding()
                
                List {
                    ForEach(0..<game.players.count, id: \.self) { index in
                        let player = game.players[index]
                        HStack {
                            Text(player.name)
                                .font(.title3)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Total: \(player.totalScore)")
                                    .font(.headline)
                                
                                if !player.scores.isEmpty {
                                    Text("Last: \(player.scores.last ?? 0)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Button(action: {
                                selectedPlayerIndex = index
                                showingScoreSheet = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                Button(action: {
                    showEndGameAlert = true
                }) {
                    Text("End Game")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showEndGameAlert) {
                    Alert(
                        title: Text("End Game"),
                        message: Text("Are you sure you want to end this game?"),
                        primaryButton: .destructive(Text("End Game")) {
                            gameManager.completeCurrentGame()
                        },
                        secondaryButton: .cancel()
                    )
                }
            } else {
                Text("No active game")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("RummyScorer")
        .sheet(isPresented: $showingScoreSheet) {
            AddScoreView(playerIndex: selectedPlayerIndex)
        }
    }
}

*/

//round score new version for 2nd attempt start
import SwiftUI

struct CurrentGameView: View {
    @EnvironmentObject private var gameManager: GameManager
    @State private var showingScoreSheet = false
    @State private var showingRoundScoreSheet = false  // New state for round scoring
    @State private var selectedPlayerIndex = 0
    @State private var showEndGameAlert = false
    
    var body: some View {
        VStack {
            if let game = gameManager.currentGame {
                Text("Round \(game.currentRound + 1)")
                    .font(.headline)
                    .padding()
                
                List {
                    // Existing list of players and scores
                    ForEach(0..<game.players.count, id: \.self) { index in
                        let player = game.players[index]
                        HStack {
                            Text(player.name)
                                .font(.title3)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Total: \(player.totalScore)")
                                    .font(.headline)
                                
                                if !player.scores.isEmpty {
                                    Text("Last: \(player.scores.last ?? 0)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Button(action: {
                                selectedPlayerIndex = index
                                showingScoreSheet = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                // Add Round Scoring button
                Button(action: {
                    showingRoundScoreSheet = true
                }) {
                    Text("Score This Round")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                    showEndGameAlert = true
                }) {
                    Text("End Game")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showEndGameAlert) {
                    Alert(
                        title: Text("End Game"),
                        message: Text("Are you sure you want to end this game?"),
                        primaryButton: .destructive(Text("End Game")) {
                            gameManager.completeCurrentGame()
                        },
                        secondaryButton: .cancel()
                    )
                }
            } else {
                Text("No active game")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("RummyScorer")
        .sheet(isPresented: $showingScoreSheet) {
            AddScoreView(playerIndex: selectedPlayerIndex)
        }
        .sheet(isPresented: $showingRoundScoreSheet) {
            RoundScoreView()
        }
    }
    
    
}
