import SwiftUI

struct DialogsScreen: View {
    
    @State private var lastAction = "Još nije odabrana nijedna radnja"
    
    var body: some View {
        List{
            // gumbi
            
            Section("Zadnja reakcija korisnika"){
                Text(lastAction).foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Dijalozi")
        // dijalozi
    }
}

#Preview {
    NavigationStack {
        DialogsScreen()
    }
}
