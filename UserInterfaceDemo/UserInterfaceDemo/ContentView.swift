import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Poruke unutar aplikacije") {
                    NavigationLink {
                        DialogsScreen()
                    } label: {
                        Text("Dijalozi")
                    }

                    NavigationLink {
                        ToastScreen()
                    } label: {
                        Text("Toast")
                    }

                    NavigationLink {
                        SnackbarScreen()
                    } label: {
                        Text("Snackbar")
                    }

                    NavigationLink {
                        FABScreen()
                    } label: {
                        Text("FAB")
                    }
                }

                Section("Sistemske notifikacije") {
                    NavigationLink {
                        SimpleNotificationScreen()
                    } label: {
                        Text("Jednostavna notifikacija")
                    }

                    NavigationLink {
                        RichNotificationScreen()
                    } label: {
                        Text("Složena notifikacija")
                    }
                }
            }
            .navigationTitle("Interakcija s korisnikom")
        }
    }
}

#Preview {
    ContentView()
}
