import SwiftUI

struct FABScreen: View {
    var body: some View {
        Text("Ovdje dolaze primjeri FAB-a.")
            .navigationTitle("FAB")
    }
}

#Preview {
    NavigationStack {
        FABScreen()
    }
}
