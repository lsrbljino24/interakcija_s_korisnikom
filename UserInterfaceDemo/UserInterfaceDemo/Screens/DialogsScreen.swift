import SwiftUI

struct DialogsScreen: View {
    
    @State private var lastAction = "Još nije odabrana nijedna radnja"
    @State private var showInfoAlert = false
    @State private var showDeleteAlert = false
    
    
    var body: some View {
        List{
            // gumbi
            Section("Alert"){
                Button("Informativni alert"){
                    showInfoAlert = true
                }
                Button("Potvrda brisanja"){
                    showDeleteAlert = true
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
        .alert("Obrisati fotografiju?", isPresented: $showDeleteAlert){
            Button("Obriši", role: .destructive){
                lastAction = "Korisnik je obrisao fotogrfiju"
            }
            Button("Odustani", role: .cancel){
                lastAction = "Korisik je odustao od brisanja"
            }
        }message:{
            Text("Ova radnja se ne može poništiti")
        }
    }
}

#Preview {
    NavigationStack {
        DialogsScreen()
    }
}
