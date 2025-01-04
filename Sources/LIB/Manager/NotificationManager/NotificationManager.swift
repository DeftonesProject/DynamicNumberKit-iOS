import Foundation
import UserNotifications
import UIKit
import UserAcquisition

public protocol NotificationManagerDelegate: AnyObject {
    func handleActivationRefund(balance: Int, change: Int)
    func handleActivationCode(notification: PushNotification)
}

public class NotificationManager: NSObject {
    public static let shared = NotificationManager()
    public weak var delegate: NotificationManagerDelegate?
    
    
    public enum PushAuthorizationStatus {
        case authorized
        case denied
        case notDetermined
    }
    
    public func checkPushAuthorizationStatus(completion: @escaping (PushAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let status: PushAuthorizationStatus
            switch settings.authorizationStatus {
            case .authorized:
                status = .authorized
            case .denied:
                status = .denied
            case .notDetermined:
                status = .notDetermined
            default:
                status = .denied
            }
            DispatchQueue.main.async {
                completion(status)
            }
        }
    }
    private override init() {}
    
    public func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Failed to request notification authorization: \(error)")
            }
            completion(granted)
        }
    }
    
    public func registerForRemoteNotifications() {
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    public func didRegisterForRemoteNotificationsWithDeviceToken(_ deviceToken: Data) -> String {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        _Concurrency.Task {
            let result = try await GetSMS.shared.nw.registerPush(pushToken: token)
        }
        return token
    }
    
    public func didFailToRegisterForRemoteNotificationsWithError(_ error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }
    
    public func handleRemoteNotification(userInfo: [AnyHashable: Any], completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: userInfo, options: [])
            let notification = try JSONDecoder().decode(PushNotification.self, from: jsonData)
            
            switch notification.event {
            case .activationRefund:
                if let balance = notification.balance, let change = notification.change {
                    delegate?.handleActivationRefund(balance: balance, change: change)
                }
                completionHandler(.newData)
                
            case .activationCode:
                if let code = notification.code, let number = notification.number {
                    delegate?.handleActivationCode(notification: notification)
                }
                completionHandler(.newData)
                
            case .unknown:
                print("Unknown event received")
                completionHandler(.noData)
            }
        } catch {
            print("Failed to decode notification: \(error)")
            completionHandler(.failed)
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("Notification response received: \(userInfo)")
        completionHandler()
    }
}
