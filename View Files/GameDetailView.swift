
import SwiftUI

struct GameDetailView: View {
    let game: Game
    
    var body: some View {
        List {
            Section(header: Text("Final Scores")) {
                ForEach(game.players.sorted(by: { $0.totalScore < $1.totalScore })) { player in
                    HStack {
                        Text(player.name)
                        Spacer()
                        Text("\(player.totalScore)")
                            .font(.headline)
                    }
                }
            }
            
            Section(header: Text("Round by Round")) {
                ForEach(0..<(game.players.first?.scores.count ?? 0), id: \.self) { roundIndex in
                    VStack(alignment: .leading) {
                        Text("Round \(roundIndex + 1)")
                            .font(.headline)
                        
                        ForEach(game.players) { player in
                            if roundIndex < player.scores.count {
                                HStack {
                                    Text(player.name)
                                    Spacer()
                                    Text("\(player.scores[roundIndex])")
                                }
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Game Details")
    }
}

#Preview {
    //ContentView()
    //   RummyScorerApp()
   // GameDetailView(game: <#T##Game#>)
    //}
    
}
