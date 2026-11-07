import SwiftUI

@main
struct UserInterfaceDemoApp: App {
    
    init(){
        NotificationManager.shared.setUp()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
