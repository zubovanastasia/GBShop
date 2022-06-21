//
//  AppDelegate.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 22.03.2022.
//

import UIKit
import Firebase
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let key = APIKeyGoogleMaps().keyMaps
        FirebaseApp.configure()
        GMSServices.provideAPIKey(key)
        
        registerPermission()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    // MARK: Notifications private methods.
    private func registerPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            guard let self = self else { return }
            guard granted else {
                print("Permission not granted")
                return
            }
            //TODO: Create content.
            let content = self.createContent()
            //TODO: Create trigger.
            let trigger = self.createTrigger()
            self.sendNoteficationRequest(content: content, trigger: trigger)
        }
    }
    private func createContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Тук-тук!👋🏼"
        content.subtitle = "Заметили, что вы давно к нам не заходили"
        content.body = "Возвращайтесь!😉"
        content.badge = 1
        return content
    }
    private func createTrigger() -> UNNotificationTrigger {
        UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    }
    private func sendNoteficationRequest(content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: "timeNotification", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
