//
//  RausisViewModel.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 19.06.22.
//

import Foundation

class RausisViewModel: GenericTechniqueViewModel {
    init(numberOfChainedAlarms: Int = 2, timeBetweenAlarms: Int = 3, turnOffAfter: Int = 30, isChainingEnabled: Bool = true) {
        self.timeBetweenAlarms = timeBetweenAlarms
        self.isChainingEnabled = isChainingEnabled
        self.numberOfChainedAlarms = numberOfChainedAlarms
        turnOfAfterSeconds = turnOffAfter
        super.init(type: .RAUSIS)

        $isChainingEnabled.receive(on: RunLoop.main).map { _ in self.toAlarms(morningAlarms: self.morningAlarms, wbtbAlarms: self.wbtbAlarms) }.assign(to: &$allAlarms)
    }

    @Published var isChainingEnabled: Bool
    @Published var numberOfChainedAlarms: Int
    @Published var timeBetweenAlarms: Int
    @Published var turnOfAfterSeconds: Int

    override func toAlarms(morningAlarms: [LDAlarm], wbtbAlarms: [LDAlarm]) -> [LDAlarm] {
        var alarmsToCreate: [LDAlarm] = wbtbAlarms
        alarmsToCreate[0].repeats = turnOfAfterSeconds / 10
        if isChainingEnabled {
            for i in 1 ... numberOfChainedAlarms {
                // E.g turnOfAfterSeconds 30 secs, alarm sound = 10 secs (30 / 10 = repeat 3 times)
                alarmsToCreate.append(LDAlarm(date: (wbtbAlarms.last?.date.addingTimeInterval(timeBetweenAlarms.minutes * Double(i)))!, repeats: turnOfAfterSeconds / 10))
            }
        }
        alarmsToCreate.append(contentsOf: morningAlarms)
        return alarmsToCreate
    }
}
