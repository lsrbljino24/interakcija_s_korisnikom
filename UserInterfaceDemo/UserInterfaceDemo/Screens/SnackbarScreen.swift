import SwiftUI

struct SnackbarScreen: View {
    var body: some View {
        Text("Ovdje dolaze primjeri Snackbara.")
            .navigationTitle("Snackbar")
    }
}

#Preview {
    NavigationStack {
        SnackbarScreen()
    }
}
