import SwiftUI

@main
struct SwiftAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NavigationLink(destination: Text("Details")) {
                    PokeDescriptionView()
                }
            }
//            HomeView()
        }
    }
}
