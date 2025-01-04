//
//  AppDelegate.swift
//  Example
//
//  Created by User on 22.11.24.
//

import UIKit
import GETSms

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureGetSMS()
        return true
    }
    
    private func configureGetSMS() {
        NotificationManager.shared.requestAuthorization { result in
            NotificationManager.shared.delegate = self
            NotificationManager.shared.registerForRemoteNotifications()
        }
        let inAppIDs = [
            "InAppIDs"
        ]
        GetSMS.shared.configure(model: ConfigurationApp(baseURL: "URL", productIdentifiers: inAppIDs, userAcquisitionModel: UserAcquisitionModel(userAcquisitionAPIKey: "userAcquisitionAPIKEY", amplitudeID: "amplitudeID", appMetricaID: "amplitudeID")))
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
       let _ = NotificationManager.shared.didRegisterForRemoteNotificationsWithDeviceToken(deviceToken)
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NotificationManager.shared.handleRemoteNotification(userInfo: userInfo, completionHandler: completionHandler)
    }
}

extension AppDelegate: NotificationManagerDelegate {
    func handleActivationRefund(balance: Int, change: Int) {
        CreditManager.shared.updateCredit(newAmount: balance)
    }
    
    func handleActivationCode(code: String, number: String) {
        print("Received code \(code) from number \(number)")
    }
}

