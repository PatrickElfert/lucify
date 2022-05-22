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
    @Published var techniquePreset: TechniquePreset
    @Published var numberOfRausisAlarms: Int
    var runningAlarms: [LDAlarm] = []
    var techniquePresets: [Technique:TechniquePreset]
    
    init() {
        selectedMethod = Technique.RAUSIS
        numberOfRausisAlarms = 2
        techniquePresets = [
            Technique.RAUSIS: TechniquePreset(),
            Technique.FILD: TechniquePreset(),
            Technique.SSILD: TechniquePreset(),
            Technique.MILD: TechniquePreset(isWbtbOptional: true)
        ]
        techniquePreset = techniquePresets[Technique.RAUSIS]!
    }
    
    func setTechniquePreset(technique: Technique) -> Void {
        techniquePreset = techniquePresets[technique]!
    }
    
    func setAlarms() throws -> Void {
        guard let url = Bundle.main.url(forResource: "scifi", withExtension: "mp3") else { return }
        for alarm in calculateAlarmsToCreate() {
            let alarmToRun = LDAlarm(date: alarm.date, audioPlayer: try AVAudioPlayer(contentsOf: url))
            guard let audioPlayer = alarmToRun.audioPlayer else { return }
            audioPlayer.prepareToPlay()
            audioPlayer.play(atTime: alarm.date.timeIntervalSinceNow)
            runningAlarms.append(alarmToRun)
        }
    }
    
    private func calculateAlarmsToCreate() -> [LDAlarm] {
        var alarmsToCreate = techniquePreset.isWbtbVisible ? [techniquePreset.wbtbAlarms, techniquePreset.morningAlarms].flatMap {$0} : techniquePreset.morningAlarms
        if(selectedMethod == .RAUSIS) {
            let lastWbtbAlarm = techniquePreset.wbtbAlarms.last
            for i in 1...numberOfRausisAlarms {
                alarmsToCreate.append(LDAlarm(date: (lastWbtbAlarm?.date.addingTimeInterval(2.minutes * Double(i)))!))
            }
        }
        return alarmsToCreate
    }
}

struct LDAlarm: Identifiable {
    init(date: Date, audioPlayer: AVAudioPlayer? = nil) {
        self.audioPlayer = audioPlayer
        self.date = date
        self.id = UUID()
    }
    
    init(fromNow: TimeInterval) {
        self.date = Date.now.addingTimeInterval(fromNow)
        self.id = UUID()
    }
    var id: UUID
    var date: Date
    var audioPlayer: AVAudioPlayer?    
}

extension Int {
    var hours: TimeInterval {
        TimeInterval(self * 60 * 60)
    }
    var minutes: TimeInterval {
        TimeInterval(self * 60)
    }
    var seconds: TimeInterval {
        TimeInterval(self)
    }
}

struct TechniquePreset {
    init(morningAlarms: [LDAlarm] = [LDAlarm(fromNow: 9.hours)],
         wbtbAlarms: [LDAlarm] = [LDAlarm(fromNow: 6.hours)],
         repeatWbtb: Int = 0,
         isWbtbOptional: Bool = false,
         isWbtbVisible: Bool = true) {
        self.morningAlarms = morningAlarms
        self.wbtbAlarms = wbtbAlarms
        self.isWbtbOptional = isWbtbOptional
        self.isWbtbVisible = isWbtbVisible
        self.repeatWbtb = repeatWbtb
    }
    
    var isWbtbOptional: Bool
    var isWbtbVisible: Bool
    var morningAlarms: [LDAlarm]
    var wbtbAlarms: [LDAlarm]
    var repeatWbtb: Int
}

enum Technique: String, CaseIterable {
    case RAUSIS = "RAUSIS"
    case FILD = "FILD"
    case MILD = "MILD"
    case SSILD = "SSILD"
}
