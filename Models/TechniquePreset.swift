//
//  TechniquePreset.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import Foundation
import Combine

protocol Preset {
    var wbtbAlarms: [LDAlarm] {get set}
    var morningAlarms: [LDAlarm] {get set}
    var type: Technique {get set}
    var allAlarms: [LDAlarm] {get set}
}

class TechniquePreset: ObservableObject, Preset {
    init(type: Technique, morningAlarms: [LDAlarm] = [LDAlarm(fromNow: 9.hours)],
         wbtbAlarms: [LDAlarm] = [LDAlarm(fromNow: 6.hours)]) {
        self.morningAlarms = morningAlarms
        self.wbtbAlarms = wbtbAlarms
        self.type = type
        
        Publishers.CombineLatest($morningAlarms, $wbtbAlarms).receive(on: RunLoop.main)
            .map {morningAlarms, wbtbAlarms in self.toAlarms(morningAlarms: morningAlarms, wbtbAlarms: wbtbAlarms)}.assign(to: &$allAlarms)
    }
    
    var type: Technique
    @Published var allAlarms: [LDAlarm] = []
    @Published var morningAlarms: [LDAlarm] = []
    @Published var wbtbAlarms: [LDAlarm] = []
    
    func toAlarms(morningAlarms: [LDAlarm], wbtbAlarms: [LDAlarm]) -> [LDAlarm] {
        [wbtbAlarms, morningAlarms].flatMap {$0}
    }
}

class MildPreset: TechniquePreset {
    init(isWbtbEnabled: Bool = true) {
        self.isWbtbEnabled = isWbtbEnabled
        super.init(type: .MILD)
        $isWbtbEnabled.receive(on: RunLoop.main).map {_ in print(isWbtbEnabled); return self.toAlarms(morningAlarms: self.morningAlarms, wbtbAlarms: self.wbtbAlarms)}.assign(to: &$allAlarms)
    }
    @Published var isWbtbEnabled: Bool
    override func toAlarms(morningAlarms: [LDAlarm], wbtbAlarms: [LDAlarm]) -> [LDAlarm] {
        return isWbtbEnabled ? [wbtbAlarms, morningAlarms].flatMap {$0} : morningAlarms
    }
}

class RausisPreset: TechniquePreset {
    init(numberOfChainedAlarms: Int = 2, isChainingEnabled: Bool = true) {
        self.isChainingEnabled = isChainingEnabled
        self.numberOfChainedAlarms = numberOfChainedAlarms
        super.init(type: .RAUSIS)
        
        $isChainingEnabled.receive(on: RunLoop.main).map {_ in self.toAlarms(morningAlarms: self.morningAlarms, wbtbAlarms: self.wbtbAlarms)}.assign(to: &$allAlarms)
    }
    @Published var isChainingEnabled: Bool
    @Published var numberOfChainedAlarms: Int
    
    override func toAlarms(morningAlarms: [LDAlarm], wbtbAlarms: [LDAlarm]) -> [LDAlarm] {
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
