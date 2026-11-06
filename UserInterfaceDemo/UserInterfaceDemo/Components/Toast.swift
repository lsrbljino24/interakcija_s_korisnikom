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

struct ToastModifier: ViewModifier {
    @Binding var toast: Toast?
    
    func body(content: Content) -> some View{
        content.overlay(alignment: .bottom){
            if let toast{
                ToastView(toast: toast)
                    .padding(.bottom, 32)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: toast)
    }
}

extension View{
    func toast(_ toast: Binding<Toast?>) -> some View{
        modifier(ToastModifier(toast: toast))
    }
}





#Preview{
    ToastView(toast: Toast(message: "Postavke su spremljene"))
}
