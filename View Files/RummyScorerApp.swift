
import SwiftUI

@main
struct RummyScorerApp: App {
    @StateObject private var gameManager = GameManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    if gameManager.currentGame != nil {
                        CurrentGameView()
                    } else {
                        NewGameView()
                    }
                }
                .tabItem {
                    Label("Game", systemImage: "gamecontroller")
                }
                
                NavigationView {
                    GameHistoryView()
                }
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            }
            .environmentObject(gameManager)
        }
    }
}

struct MyApp: App {
  var body: some Scene {
    WindowGroup {
      //RootView()
      //  RummyScorerApp()
    }
  }
}

#Preview {
    //ContentView()
    //   MyApp()
    // RummyScorerApp()
    //}
    
}

