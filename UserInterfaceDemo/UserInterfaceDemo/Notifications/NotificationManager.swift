import UserNotifications
import Observation

@MainActor
@Observable

final class NotificationManager: NSObject{
    static let shared = NotificationManager()
    
    var lastAction = "Još nema reakcija na notifikaciju."
    
    private let center = UNUserNotificationCenter.current()
    
    func setUp(){
        center.delegate = self
    }
    
    func requestAutorization() async -> Bool{
        let granted = (try? await center.requestAuthorization(options: [.alert, .sound])) ?? false
        if !granted{
            lastAction = "Notifikacije nisu dopuštene. Uključi ih u postavkama."
        }
        return granted
    }
    
    func sendSimpleNotification() async {
        guard await requestAutorization() else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Podsjetnik"
        content.body = "Vrijeme je za kratku pauzu."
        content.sound = .default
        
        await schedule(content)
    }
    
    private func schedule(_ content: UNNotificationContent) async {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        try? await center.add(request)
    }
}


extension NotificationManager: UNUserNotificationCenterDelegate{
    nonisolated func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions{
        [.banner, .sound]
    }
    
    nonisolated func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async{
        await handleAction(response.actionIdentifier)
    }
    
    private func handleAction(_ identifier: String){
        switch identifier{
            case UNNotificationDefaultActionIdentifier:
                lastAction = "Korisnik je dodirnuo notifikaicju"
        default:
            break
        }
    }
}
