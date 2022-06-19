//
//  MildViewModel.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 19.06.22.
//

import Foundation

class MildViewModel: GenericTechniqueViewModel {
    init(isWbtbEnabled: Bool = true) {
        self.isWbtbEnabled = isWbtbEnabled
        super.init(type: .MILD)
        $isWbtbEnabled.receive(on: RunLoop.main).map { _ in print(isWbtbEnabled); return self.toAlarms(morningAlarms: self.morningAlarms, wbtbAlarms: self.wbtbAlarms) }.assign(to: &$allAlarms)
    }

    @Published var isWbtbEnabled: Bool
    override func toAlarms(morningAlarms: [LDAlarm], wbtbAlarms: [LDAlarm]) -> [LDAlarm] {
        return isWbtbEnabled ? [wbtbAlarms, morningAlarms].flatMap { $0 } : morningAlarms
    }
}
