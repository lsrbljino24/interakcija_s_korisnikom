import SwiftUI

struct RichNotificationScreen: View {
    private let manager = NotificationManager.shared
    
    var body: some View {
        List{
            Section{
                Button("Pošalji pozivnicu za 5 sekundi"){
                    Task{await manager.sendRichNotification()}
                }
            }footer: {
                Text("Dugo pritisni notifikaciju ili je povuci prema dolje za prikaz slike i gumba")
            }
            
            Section("Zadnja reakcija korisnika"){
                Text(manager.lastAction).foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Složena notifikacija")
    }
}

#Preview {
    NavigationStack {
        RichNotificationScreen()
    }
}
