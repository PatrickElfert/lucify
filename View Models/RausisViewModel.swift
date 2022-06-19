//
//  RausisViewModel.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 19.06.22.
//

import Foundation

class RausisViewModel: GenericTechniqueViewModel {
    init(numberOfChainedAlarms: Int = 2, isChainingEnabled: Bool = true) {
        self.isChainingEnabled = isChainingEnabled
        self.numberOfChainedAlarms = numberOfChainedAlarms
        super.init(type: .RAUSIS)

        $isChainingEnabled.receive(on: RunLoop.main).map { _ in self.toAlarms(morningAlarms: self.morningAlarms, wbtbAlarms: self.wbtbAlarms) }.assign(to: &$allAlarms)
    }

    @Published var isChainingEnabled: Bool
    @Published var numberOfChainedAlarms: Int

    override func toAlarms(morningAlarms: [LDAlarm], wbtbAlarms: [LDAlarm]) -> [LDAlarm] {
        var alarmsToCreate: [LDAlarm] = wbtbAlarms
        if isChainingEnabled {
            for i in 1 ... numberOfChainedAlarms {
                alarmsToCreate.append(LDAlarm(date: (wbtbAlarms.last?.date.addingTimeInterval(2.minutes * Double(i)))!))
            }
        }
        alarmsToCreate.append(contentsOf: morningAlarms)
        return alarmsToCreate
    }
}
