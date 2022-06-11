//
//  Alarm.swift
//  Lucify
//
//  Created by Patrick Elfert on 16.05.22.
//

import Foundation
import SwiftUI
import AVFoundation

class AlarmManager: ObservableObject {
    
    @Published var runningAlarms: [LDAlarm]
    var notificationManager = NotificationManager.shared
    
    init(runningAlarms: [LDAlarm] = []) {
        self.runningAlarms = runningAlarms
    }
    
    public func setAlarms(alarms: [LDAlarm]) -> Void {
        NotificationManager.shared.requestPermission()
        guard let url = Bundle.main.url(forResource: "scifi", withExtension: "mp3") else { return }
        for alarm in alarms {
            do {
                NotificationManager.shared.addNotification(id: alarm.id.uuidString, title: "Alarm", date: alarm.date )
                let alarmToRun = LDAlarm(date: alarm.date, audioPlayer: try AVAudioPlayer(contentsOf: url), id: alarm.id)
                guard let audioPlayer = alarmToRun.audioPlayer else { return }
                audioPlayer.numberOfLoops = 20
                audioPlayer.play(atTime: audioPlayer.deviceCurrentTime + alarm.date.timeIntervalSinceNow)
                runningAlarms.append(alarmToRun)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    public func cancelAlarms() -> Void {
        runningAlarms = []
    }
    
    public var allAlarmsCompleted: Bool {
        !runningAlarms.contains {!$0.isCompleted}
    }
    
    public func completeAlarm(uuid: String) -> Void {
        print(uuid)
        let alarm = runningAlarms.first {
            $0.id.uuidString == uuid}
        alarm?.isCompleted = true
        alarm?.audioPlayer?.stop()
    }
    
    
}
