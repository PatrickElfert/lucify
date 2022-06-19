//
//  TechniquePreset.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import Combine
import Foundation

protocol TechniqueViewModel {
    var type: Technique { get set }
    var wbtbAlarms: [LDAlarm] { get set }
    var morningAlarms: [LDAlarm] { get set }
    var allAlarms: [LDAlarm] { get set }
    func toAlarms(morningAlarms: [LDAlarm], wbtbAlarms: [LDAlarm]) -> [LDAlarm]
}

class GenericTechniqueViewModel: ObservableObject, TechniqueViewModel {
    init(type: Technique, morningAlarms: [LDAlarm] = [LDAlarm(fromNow: 9.hours)],
         wbtbAlarms: [LDAlarm] = [LDAlarm(fromNow: 6.hours)])
    {
        self.morningAlarms = morningAlarms
        self.wbtbAlarms = wbtbAlarms
        self.type = type

        Publishers.CombineLatest($morningAlarms, $wbtbAlarms).receive(on: RunLoop.main)
            .map { morningAlarms, wbtbAlarms in self.toAlarms(morningAlarms: morningAlarms, wbtbAlarms: wbtbAlarms) }.assign(to: &$allAlarms)
    }

    var type: Technique
    @Published var allAlarms: [LDAlarm] = []
    @Published var morningAlarms: [LDAlarm] = []
    @Published var wbtbAlarms: [LDAlarm] = []

    func toAlarms(morningAlarms: [LDAlarm], wbtbAlarms: [LDAlarm]) -> [LDAlarm] {
        [wbtbAlarms, morningAlarms].flatMap { $0 }
    }
}
