import SwiftUI

struct SnackbarScreen: View {
    
    @State private var messages = [
        "Sastanak u 10 sati",
        "Račun za studeni",
        "Potvrda rezervacije",
        "Pozivnica za rođendan",
        "Novi komentar na objavu"
    ]
    @State private var snackbar: Snackbar?
    
    var body: some View {
        List{
            Section{
                ForEach(messages, id: \.self){ message in
                    Label(message, systemImage: "envelope")
                }
                .onDelete(perform: deleteMessage)
            }footer: {
                Text("Povuci poruku u lijevo kako bi je obrisao")
            }
        }
        .navigationTitle("Snackbar")
        .snackbar($snackbar)
    }
    
    private func deleteMessage(at offsets: IndexSet) {
        guard let index = offsets.first else {return}
        let deletedMessage = messages.remove(at: index)
        
        snackbar = Snackbar(message: "Poruka je obrisana", actionTitle: "Poništi"){
            withAnimation{
                messages.insert(deletedMessage, at: index)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SnackbarScreen()
    }
}
