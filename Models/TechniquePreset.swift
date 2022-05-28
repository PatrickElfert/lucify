//
//  TechniquePreset.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import Foundation

protocol Preset {
    var wbtbAlarms: [LDAlarm] {get set}
    var morningAlarms: [LDAlarm] {get set}
    var type: Technique {get set}
    var allAlarms: [LDAlarm] {get}
}

class TechniquePreset: ObservableObject, Preset {
    init(type: Technique, morningAlarms: [LDAlarm] = [LDAlarm(fromNow: 9.hours)],
         wbtbAlarms: [LDAlarm] = [LDAlarm(fromNow: 6.hours)]) {
        self.morningAlarms = morningAlarms
        self.wbtbAlarms = wbtbAlarms
        self.type = type
    }
    
    var type: Technique
    @Published var morningAlarms: [LDAlarm]
    @Published var wbtbAlarms: [LDAlarm]
    
    var allAlarms: [LDAlarm] {
        [wbtbAlarms, morningAlarms].flatMap {$0}
    }
}

class MildPreset: TechniquePreset {
    init(isWbtbEnabled: Bool = true) {
        self.isWbtbEnabled = isWbtbEnabled
        super.init(type: .MILD)
    }
    @Published var isWbtbEnabled: Bool
    override var allAlarms: [LDAlarm] {
        isWbtbEnabled ? [wbtbAlarms, morningAlarms].flatMap {$0} : morningAlarms
    }
}

class RausisPreset: TechniquePreset {
    init(numberOfChainedAlarms: Int = 2, isChainingEnabled: Bool = true) {
        self.isChainingEnabled = isChainingEnabled
        self.numberOfChainedAlarms = numberOfChainedAlarms
        super.init(type: .RAUSIS)
    }
    @Published var isChainingEnabled: Bool
    @Published var numberOfChainedAlarms: Int
    
    override var allAlarms: [LDAlarm] {
        var alarmsToCreate: [LDAlarm] = wbtbAlarms
        if(isChainingEnabled) {
            for i in 1...numberOfChainedAlarms{
                alarmsToCreate.append(LDAlarm(date: (wbtbAlarms.last?.date.addingTimeInterval(2.minutes * Double(i)))!))
            }
        }
        alarmsToCreate.append(contentsOf: morningAlarms)
        return alarmsToCreate
    }
}
