import SwiftUI

struct Snackbar: Equatable {
    let id = UUID()
    let message: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil
    
    static func == (lhs: Snackbar, rhs: Snackbar) -> Bool {
        lhs.id == rhs.id
    }
}

struct SnackbarView: View {
    let snackbar: Snackbar
    let onDismiss: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Text(snackbar.message)
                .font(.subheadline)
                .foregroundStyle(Color(.systemBackground))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let actionTitle = snackbar.actionTitle {
                Button(actionTitle){
                    snackbar.action?()
                    onDismiss()
                }
                .font(.subheadline.bold())
            }
            
            Button{
                onDismiss()
            }label:{
                Image(systemName: "xmark")
                    .foregroundStyle(Color(.systemBackground))
            }
            .accessibilityLabel("Zatvori")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(.primary, in: RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 4, y: 2)
    }
}

#Preview {
    SnackbarView(
        snackbar: Snackbar(message: "Poruka je obrisana", actionTitle: "Poništi"),
        onDismiss: {}
    )
    .padding()
}
