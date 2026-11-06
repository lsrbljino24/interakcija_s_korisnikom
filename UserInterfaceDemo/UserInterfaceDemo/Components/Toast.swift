import SwiftUI

struct Toast: Equatable {
    let id = UUID()
    let message: String
    var systemImage: String = "checkmark.circle.fill"
}

struct ToastView: View{
    let toast: Toast
    
    var body: some View {
        Label(toast.message, systemImage: toast.systemImage)
            .font(.subheadline)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(.regularMaterial, in: Capsule())
            .shadow(radius: 4, y: 2)
    }
}

#Preview{
    ToastView(toast: Toast(message: "Postavke su spremljene"))
}
