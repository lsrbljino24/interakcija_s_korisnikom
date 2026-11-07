import SwiftUI

struct FloatingActionButton: View{
    let title: String
    let systemImage: String
    let action: () -> Void
    
    var body: some View{
        Button(action: action){
            Image(systemName: systemImage)
                .font(.title2.weight(.semibold))
                .frame(width: 56, height: 56)
                .foregroundStyle(.white)
                .background(.tint, in: Circle())
                .shadow(radius: 6, y: 3)
        }
        .accessibilityLabel(title)
    }
}

#Preview {
    FloatingActionButton(title: "Nova bilješka", systemImage: "plus"){}
}
