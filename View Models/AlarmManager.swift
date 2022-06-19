//
//  Alarm.swift
//  Lucify
//
//  Created by Patrick Elfert on 16.05.22.
//

import AVFoundation
import Foundation
import SwiftUI

class AlarmManager: ObservableObject {
    @Published var runningAlarms: [LDAlarm]
    var notificationManager = NotificationManager.shared
    private let dateGenerator: () -> Date

    init(runningAlarms: [LDAlarm] = [], dateGenerator: @escaping () -> Date = Date.init) {
        self.dateGenerator = dateGenerator
        self.runningAlarms = runningAlarms
    }

    public func setAlarms(alarms: [LDAlarm]) {
        NotificationManager.shared.requestPermission()
        guard let url = Bundle.main.url(forResource: "scifi", withExtension: "mp3") else { return }
        for alarm in alarms {
            do {
                NotificationManager.shared.addNotification(id: alarm.id.uuidString, title: "Alarm", date: alarm.date)
                let alarmToRun = LDAlarm(date: alarm.date.time(in: dateGenerator()), audioPlayer: try AVAudioPlayer(contentsOf: url), id: alarm.id)
                guard let audioPlayer = alarmToRun.audioPlayer else { return }
                audioPlayer.numberOfLoops = 20
                audioPlayer.play(atTime: audioPlayer.deviceCurrentTime + alarm.date.timeIntervalSinceNow)
                runningAlarms.append(alarmToRun)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    public func cancelAlarms() {
        runningAlarms = []
    }

    public var allAlarmsCompleted: Bool {
        !runningAlarms.contains { !$0.isCompleted }
    }

    public func completeAlarm(uuid: String) {
        print(uuid)
        let alarm = runningAlarms.first {
            $0.id.uuidString == uuid
        }
        alarm?.isCompleted = true
        alarm?.audioPlayer?.stop()
    }
}
