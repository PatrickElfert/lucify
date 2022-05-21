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
    
    @Published var selectedMethod: Technique
    @Published var techniquePreset: Preset
    @Published var numberOfRausisAlarms: Int
    var runningAlarms: [LDAlarm] = []
    
    init() {
        selectedMethod = Technique.RAUSIS
        numberOfRausisAlarms = 2
        let morningAlarmTime = Date.now.addingTimeInterval(60 * 60 * 9)
        let wbtbAlarmTime = Date.now.addingTimeInterval(60 * 60 * 6)
        techniquePresets = [
            Technique.RAUSIS:
                Preset(morningAlarms: [LDAlarm(date: morningAlarmTime)], wbtbAlarms: [LDAlarm(date: wbtbAlarmTime)]),
            Technique.FILD:
                Preset(morningAlarms: [LDAlarm(date: morningAlarmTime)], wbtbAlarms: [LDAlarm(date: wbtbAlarmTime)]),
            Technique.SSILD:
                Preset(morningAlarms: [LDAlarm(date: morningAlarmTime)], wbtbAlarms: [LDAlarm(date: wbtbAlarmTime)]),
            Technique.MILD:
                Preset(morningAlarms: [LDAlarm(date: Date.now)], wbtbAlarms: [LDAlarm(date: wbtbAlarmTime)], isWbtbOptional: true, isWbtbVisible: false),
        ]
        techniquePreset = techniquePresets[Technique.RAUSIS]!
    }
    
    func setTechniquePreset(technique: Technique) -> Void {
        techniquePreset = techniquePresets[technique]!
    }
    
    func setAlarms() throws -> Void {
        guard let url = Bundle.main.url(forResource: "scifi", withExtension: "mp3") else { return }
        for alarm in calculateAlarmsToCreate() {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play(atTime: alarm.date.timeIntervalSinceNow)
            var alarmToRun = LDAlarm(date: alarm.date)
            alarmToRun.audioPlayer = audioPlayer
            runningAlarms.append(alarmToRun)
        }
    }
    
    private func calculateAlarmsToCreate() -> [LDAlarm] {
        var alarmsToCreate = techniquePreset.isWbtbVisible ? [techniquePreset.wbtbAlarms, techniquePreset.morningAlarms].flatMap {$0} : techniquePreset.morningAlarms
        if(selectedMethod == .RAUSIS) {
            let lastWbtbAlarm = techniquePreset.wbtbAlarms.last
            for i in 1...numberOfRausisAlarms {
                alarmsToCreate.append(LDAlarm(date: (lastWbtbAlarm?.date.addingTimeInterval(TimeInterval(60 * i)))!))
            }
        }
        return alarmsToCreate
    }
    
    var techniquePresets: [Technique:Preset]
}



struct LDAlarm: Identifiable {
    init(date: Date) {
        self.date = date
        self.id = UUID()
    }
    var id: UUID
    var date: Date
    var audioPlayer: AVAudioPlayer?
}

struct Preset {
    init(morningAlarms: [LDAlarm] = [], wbtbAlarms: [LDAlarm] = [], isWbtbOptional: Bool = false, isWbtbVisible: Bool = true) {
        self.morningAlarms = morningAlarms
        self.wbtbAlarms = wbtbAlarms
        self.isWbtbOptional = isWbtbOptional
        self.isWbtbVisible = isWbtbVisible
    }
    
    var isWbtbOptional: Bool
    var isWbtbVisible: Bool
    var morningAlarms: [LDAlarm]
    var wbtbAlarms: [LDAlarm]
}

enum Technique: String, CaseIterable {
    case RAUSIS = "RAUSIS"
    case FILD = "FILD"
    case MILD = "MILD"
    case SSILD = "SSILD"
}
