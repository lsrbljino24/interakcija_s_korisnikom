import SwiftUI

struct DialogsScreen: View {
    
    @State private var lastAction = "Još nije odabrana nijedna radnja"
    @State private var showInfoAlert = false
    
    
    
    var body: some View {
        List{
            // gumbi
            Section("Alert"){
                Button("Informativni alert"){
                    showInfoAlert = true
                }
                
            }
            Section("Zadnja reakcija korisnika"){
                Text(lastAction).foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Dijalozi")
        // dijalozi
        .alert("Nema internetske veze" ,isPresented: $showInfoAlert) {
            Button("U redu"){
                lastAction = "Korisnik je potvrdio informativni alert"
            }
        }message: {
            Text("Provjerite vezu i pokušajte ponovo")
        }
        
    }
}

#Preview {
    NavigationStack {
        DialogsScreen()
    }
}
