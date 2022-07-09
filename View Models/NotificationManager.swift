//
//  AppDelegate.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 05.06.22.
//

import Foundation
import SwiftUI

class NotificationManager: NSObject, UNUserNotificationCenterDelegate, ObservableObject, Notifiable {
    var currentNotificationIdentifier: String?
    @Published var isNotificationActive = false

    static let shared = NotificationManager()

    /** Handle notification when app is in background */
    func userNotificationCenter(_: UNUserNotificationCenter, didReceive _:
        UNNotificationResponse, withCompletionHandler _: @escaping () -> Void) {}

    /** Handle notification when the app is in foreground */
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler _: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        currentNotificationIdentifier = notification.request.identifier
        isNotificationActive = true
    }

    func requestPermission(_ delegate: UNUserNotificationCenterDelegate? = nil,
                           onDeny handler: (() -> Void)? = nil)
    { // an optional onDeny handler is better here,
        // so there is an option not to provide one, have one only when needed
        let center = UNUserNotificationCenter.current()

        center.getNotificationSettings(completionHandler: { settings in

            if settings.authorizationStatus == .denied {
                if let handler = handler {
                    handler()
                }
                return
            }

            if settings.authorizationStatus != .authorized {
                center.requestAuthorization(options: [.alert, .sound, .badge]) {
                    _, error in

                    if let error = error {
                        print("error handling \(error)")
                    }
                }
            }

        })
        center.delegate = delegate ?? self
    }

    func addNotification(id: String, title: String, date: Date,
                         sound: UNNotificationSound)
    {
        let dateComponent = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)

        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = sound

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    func removeNotifications(_ ids: [String]) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ids)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
    }
}
