import SwiftUI

struct ToastScreen: View {
    var body: some View {
        Text("Ovdje dolaze primjeri Toasta.")
            .navigationTitle("Toast")
    }
}

#Preview {
    NavigationStack {
        ToastScreen()
    }
}
