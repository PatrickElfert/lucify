//
//  Alarm.swift
//  Lucify
//
//  Created by Patrick Elfert on 16.05.22.
//

import AVFoundation
import Foundation
import SwiftUI

protocol Notifiable {
    func addNotification(id: String, title: String, date: Date,
                         sound: UNNotificationSound)
    func removeNotifications(_ ids: [String])
}

class AlarmManager: ObservableObject {
    @Published var runningAlarms: [LDAlarm]
    var notificationManager: Notifiable
    private let dateGenerator: () -> Date

    init(runningAlarms: [LDAlarm] = [], dateGenerator: @escaping () -> Date = Date.init, notificationManager: Notifiable = NotificationManager.shared) {
        self.dateGenerator = dateGenerator
        self.runningAlarms = runningAlarms
        self.notificationManager = notificationManager

        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: .main) { _ in
            self.cancelAlarms()
        }
    }

    public func setAlarms(alarms: [LDAlarm]) {
        guard let url = Bundle.main.url(forResource: "scifi", withExtension: "mp3") else { return }
        for alarm in alarms {
            do {
                let alarmDate = alarm.date.time(in: dateGenerator())
                notificationManager.addNotification(id: alarm.id.uuidString, title: "Alarm", date: alarmDate, sound: UNNotificationSound.default)
                let alarmToRun = LDAlarm(date: alarmDate, repeats: alarm.repeats, audioPlayer: try AVAudioPlayer(contentsOf: url), id: alarm.id)
                guard let audioPlayer = alarmToRun.audioPlayer else { return }
                audioPlayer.numberOfLoops = alarmToRun.repeats
                audioPlayer.play(atTime: audioPlayer.deviceCurrentTime + alarmDate.timeIntervalSinceNow)
                runningAlarms.append(alarmToRun)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    public func cancelAlarms() {
        notificationManager.removeNotifications(runningAlarms.map { $0.id.uuidString })
        runningAlarms = []
    }

    public var allAlarmsCompleted: Bool {
        !runningAlarms.contains { !$0.isCompleted }
    }

    public func completeAlarm(uuid: String) {
        let alarm = runningAlarms.first {
            $0.id.uuidString == uuid
        }
        alarm?.isCompleted = true
        alarm?.audioPlayer?.stop()
    }
}
