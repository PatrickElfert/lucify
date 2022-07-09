//
//  TechniquePresetTests.swift
//  LucifyTests
//
//  Created by Patrick Elfert on 09.07.22.
//

import Combine
@testable import Lucify
import XCTest

class TechniquePresetTests: XCTestCase {
    var wbtbDateTime: Date!
    var morningDateTime: Date!
    var currentDateTime: Date!

    override func setUpWithError() throws {
        currentDateTime = "2022-09-03T16:10Z".toDate(.isoDateTime)!
        wbtbDateTime = currentDateTime.addingTimeInterval(9.hours)
        morningDateTime = currentDateTime.addingTimeInterval(6.hours)
    }

    func test_creates_all_rausis_alarms() throws {
        let rausisPreset = RausisViewModel()
        rausisPreset.wbtbAlarms = [LDAlarm(date: wbtbDateTime)]
        rausisPreset.morningAlarms = [LDAlarm(date: morningDateTime)]

        let alarmPublisher = rausisPreset.$allAlarms.dropFirst(2).first()
        let expectedRausisAlarms = [wbtbDateTime,
                                    wbtbDateTime.addingTimeInterval(3.minutes),
                                    wbtbDateTime.addingTimeInterval(6.minutes),
                                    morningDateTime]

        let allAlarms = try awaitPublisher(alarmPublisher)

        XCTAssertEqual(expectedRausisAlarms, allAlarms.map { $0.date })
        XCTAssertEqual([3, 3, 3, 20], allAlarms.map { $0.repeats })
    }
}
