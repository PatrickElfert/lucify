//
//  LucifyTests.swift
//  LucifyTests
//
//  Created by Patrick Elfert on 21.05.22.
//

@testable import Lucify
import XCTest

struct Notification {
    var id: String
    var title: String
    var date: Date
}

class MockNotificationManager: Notifiable {
    func removeNotifications(_ ids: [String]) {
        notifications = notifications.filter { notification in !ids.contains(where: { id in id == notification.id }) }
    }

    var notifications: [Notification] = []

    func addNotification(id: String, title: String, date: Date, sound _: UNNotificationSound) {
        notifications.append(Notification(id: id, title: title, date: date))
    }
}

class AlarmManagerTests: XCTestCase {
    var alarmManager: AlarmManager!
    var currentDateTime: Date!
    var dateFormatter = ISO8601DateFormatter()
    var wbtbDateTime: Date!
    var morningDateTime: Date!
    var notificationManager: MockNotificationManager!

    override func setUpWithError() throws {
        currentDateTime = "2022-09-03T16:10Z".toDate(.isoDateTime)!
        wbtbDateTime = currentDateTime.addingTimeInterval(9.hours)
        morningDateTime = currentDateTime.addingTimeInterval(6.hours)
        notificationManager = MockNotificationManager()
        alarmManager = AlarmManager(dateGenerator: {
            self.currentDateTime
        }, notificationManager: notificationManager)
        continueAfterFailure = false
    }

    func test_adjust_alarms_if_possible_today() {
        alarmManager.setAlarms(alarms: [LDAlarm(date: currentDateTime.addingTimeInterval(25.hours))])
        XCTAssertEqual([currentDateTime.addingTimeInterval(1.hours)], alarmManager.runningAlarms.map { $0.date })
    }

    func test_sets_correct_alarm_dates() {
        alarmManager.setAlarms(alarms: [LDAlarm(date: wbtbDateTime), LDAlarm(date: morningDateTime)])
        XCTAssertEqual([wbtbDateTime, morningDateTime], alarmManager.runningAlarms.map { $0.date })
    }

    func test_sets_number_of_loops() {
        alarmManager.setAlarms(alarms: [LDAlarm(date: wbtbDateTime, repeats: 3), LDAlarm(date: morningDateTime, repeats: 4)])
        XCTAssertEqual([3, 4], alarmManager.runningAlarms.map { $0.audioPlayer?.numberOfLoops })
    }

    func test_creates_all_notifications() {
        alarmManager.setAlarms(alarms: [LDAlarm(date: wbtbDateTime), LDAlarm(date: morningDateTime)])
        XCTAssertEqual([wbtbDateTime, morningDateTime], notificationManager.notifications.map { $0.date })
    }

    func test_reset_alarms() throws {
        alarmManager.setAlarms(alarms: [LDAlarm(date: wbtbDateTime), LDAlarm(date: morningDateTime)])
        alarmManager.cancelAlarms()
        XCTAssert(alarmManager.runningAlarms.isEmpty)
        XCTAssert(notificationManager.notifications.isEmpty)
    }
}
