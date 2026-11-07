import UserNotifications
import Observation

@MainActor
@Observable

final class NotificationManager: NSObject{
    static let shared = NotificationManager()
    
    var lastAction = "Još nema reakcija na notifikaciju."
    
    private let center = UNUserNotificationCenter.current()
    
    func requestAutorization() async -> Bool{
        let granted = (try? await center.requestAuthorization(options: [.alert, .sound])) ?? false
        if !granted{
            lastAction = "Notifikacije nisu dopuštene. Uključi ih u postavkama."
        }
        return granted
    }
}
