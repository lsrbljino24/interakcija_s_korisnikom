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
        
        let accept = UNNotificationAction(identifier: "ACCEPT", title: "Prihvati", options:[])
        let decline = UNNotificationAction(identifier: "DECLINE", title: "Odbij", options:[.destructive])
        
        let invitation = UNNotificationCategory(
            identifier: "INVITATION",
            actions: [accept, decline],
            intentIdentifiers: [],
            options: []
        )
        center.setNotificationCategories([invitation])
        
        
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
    
    func sendRichNotification() async {
        guard await requestAutorization() else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Pozivnica"
        content.body = "Luka te poziva na seminar u ponedjeljak"
        content.sound = .default
        content.categoryIdentifier = "INVITATION"
        
        if let url = Bundle.main.url(forResource: "profile", withExtension: "png"),
            let attachment = try? UNNotificationAttachment(identifier: "slika", url: url, options: nil){
            content.attachments = [attachment]
        }
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
            case "ACCEPT":
                lastAction = "Korisnik je prihvatio pozivnicu"
            case "DECLINE":
                lastAction = "Korisnik je odbijao pozivnicu"
        default:
            break
        }
    }
}
