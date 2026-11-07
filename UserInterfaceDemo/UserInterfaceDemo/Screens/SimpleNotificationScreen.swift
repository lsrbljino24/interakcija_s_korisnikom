import SwiftUI

struct SimpleNotificationScreen: View {
    
    private let manager = NotificationManager.shared
    
    var body: some View {
        List{
            Section{
                Button("Pošalji notifikaciju za 5 sekundi"){
                    Task{await manager.sendSimpleNotification()}
                }
            }footer: {
                Text("Nakon slanja idi na početni zaslon (Cmd+Shift+H) i pričekaj")
            }
            
            Section("Zadnja reakcija korisnika"){
                Text(manager.lastAction)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Jednostavna notifikacija")
        
    }
}

#Preview {
    NavigationStack {
        SimpleNotificationScreen()
    }
}
