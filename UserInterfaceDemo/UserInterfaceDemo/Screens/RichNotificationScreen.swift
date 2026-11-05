import SwiftUI

struct RichNotificationScreen: View {
    var body: some View {
        Text("Ovdje dolaze primjeri složenih sistemskih notifikacija.")
            .navigationTitle("Složene sistemske notifikacije")
    }
}

#Preview {
    NavigationStack {
        RichNotificationScreen()
    }
}
