//
//  NotificationUnit.swift
//  LocationTracker
//
//  Created by Long Nguyen on 22/7/2022.
//

import Foundation
import UserNotifications

class NotificationUnit: NSObject {
    static let shared = NotificationUnit()
    
    let notificationCenter = UNUserNotificationCenter.current()
    var isPermissionGranted = false
    
    func requestNotificationPermission() {
        notificationCenter.requestAuthorization(options: [.alert]) { granted, error in
            if granted == true && error == nil {
                self.isPermissionGranted = true
            }
        }
    }
    
    func showNotification(title: String, body: String) -> Void {
        if isPermissionGranted {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let newRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            notificationCenter.add(newRequest)
        }
    }
}
