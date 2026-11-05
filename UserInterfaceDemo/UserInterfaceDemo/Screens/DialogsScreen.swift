import SwiftUI

struct DialogsScreen: View {
    
    @State private var lastAction = "Još nije odabrana nijedna radnja"
    @State private var showInfoAlert = false
    @State private var showDeleteAlert = false
    @State private var showRenameAlert = false
    @State private var newName = ""
    
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
                Button("Alert s unosom teksta"){
                    newName = ""
                    showRenameAlert = true
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
        .alert("Preimenuj album", isPresented: $showRenameAlert){
            TextField("Novi naziv", text: $newName)
            Button("Spremi"){
                lastAction = "Novi naziv albuma: \(newName)"
            }
            Button("Odustani", role: .cancel){
                lastAction = "Korisik je odustao od preimenovanja"
            }
        }message:{
            Text("Unesite novi naziv albuma.")
        }
    }
}

#Preview {
    NavigationStack {
        DialogsScreen()
    }
}
