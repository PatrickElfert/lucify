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
    @Published var runningAlarms: [LDAlarm] = []
    
    public func setAlarms(alarms: [LDAlarm]) -> Void {
        print ("set alarms")
        print(alarms.map {$0.date})
        guard let url = Bundle.main.url(forResource: "scifi", withExtension: "mp3") else { return }
        for alarm in alarms {
            do {
                let alarmToRun = LDAlarm(date: alarm.date, audioPlayer: try AVAudioPlayer(contentsOf: url))
                guard let audioPlayer = alarmToRun.audioPlayer else { return }
                audioPlayer.prepareToPlay()
                audioPlayer.play(atTime: alarm.date.timeIntervalSinceNow)
                runningAlarms.append(alarmToRun)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    public func cancelAlarms() -> Void {
        runningAlarms = []
        print("Cancel alarms")
    }
}
