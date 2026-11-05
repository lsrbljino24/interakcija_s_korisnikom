import SwiftUI

struct SimpleNotificationScreen: View {
    var body: some View {
        Text("Ovdje dolaze primjeri jednostavnih sistemskih notifikacija.")
            .navigationTitle("Jednostavne sistemske notifikacije")
    }
}

#Preview {
    NavigationStack {
        SimpleNotificationScreen()
    }
}
