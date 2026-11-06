import SwiftUI

struct Toast: Equatable {
    let id = UUID()
    let message: String
    var systemImage: String = "checkmark.circle.fill"
}
