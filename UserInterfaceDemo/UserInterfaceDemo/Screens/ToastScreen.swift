import SwiftUI

struct ToastScreen: View {
    
    @State private var toast: Toast?
    
    var body: some View {
        List{
            Section{
                Button("Kopiraj poveznicu"){
                    toast = Toast(message: "Poveznica je kopirana")
                }
                Button("Dodaj u favorite"){
                    toast = Toast(message: "Dodano u favorite")
                }
            }footer:{
                Text("Toast se prikazuje na dnu ekrana i nestaje nakon dvije sekunde")
            }
        }
        .navigationTitle("Toast")
        .toast($toast)
    }
}

#Preview {
    NavigationStack {
        ToastScreen()
    }
}
