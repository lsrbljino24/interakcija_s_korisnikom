import SwiftUI

struct FABScreen: View {
    
    @State private var notes = ["Bilješka 1", "Bilješka 2", "Bilješka 3"]
    
    var body: some View {
        List(notes, id: \.self){ note in
            Text(note)
        }
        .navigationTitle("FAB")
        .safeAreaInset(edge: .bottom, alignment: .trailing){
            FloatingActionButton(title: "Nova bilješka", systemImage: "plus"){
                withAnimation{
                    notes.append("Bilješka \(notes.count + 1)")
                }
            }
            .padding(16)
        }
    }
}

#Preview {
    NavigationStack {
        FABScreen()
    }
}
