//
//  LucifyTests.swift
//  LucifyTests
//
//  Created by Patrick Elfert on 21.05.22.
//

import XCTest
@testable import Lucify

class AlarmManagerTests: XCTestCase {
    var alarmManager = AlarmManager()
    let dateFormatter = ISO8601DateFormatter()
    var wbtbDate: Date!
    var morningDate: Date!
    
    override func setUpWithError() throws {
        wbtbDate = "2022-09-04T04:10Z".toDate(.isoDateTime)
        morningDate = "2022-09-04T06:10Z".toDate(.isoDateTime)
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_creates_all_rausis_alarms() throws {
        alarmManager.numberOfRausisAlarms = 2
        alarmManager.selectedMethod = .RAUSIS
        alarmManager.setTechniquePreset(technique: .RAUSIS)
        alarmManager.techniquePreset.wbtbAlarms = [LDAlarm(date: wbtbDate)]
        alarmManager.techniquePreset.morningAlarms = [LDAlarm(date: morningDate)]
        print(alarmManager.techniquePreset.wbtbAlarms)
        try alarmManager.setAlarms()
        let expectedDates = [dateFormatter.string(from: wbtbDate),
                            dateFormatter.string(from: morningDate),
                            dateFormatter.string(from: wbtbDate.addingTimeInterval(2.minutes)),
                            dateFormatter.string(from: wbtbDate.addingTimeInterval(4.minutes))]
        XCTAssert(alarmManager.runningAlarms.map {dateFormatter.string(from: $0.date )}
            .elementsEqual(expectedDates))
    }
    
    func test_respect_optional_wbtb() throws {
        alarmManager.selectedMethod = .MILD
        alarmManager.setTechniquePreset(technique: .MILD)
        alarmManager.techniquePreset.wbtbAlarms = [LDAlarm(date: wbtbDate)]
        alarmManager.techniquePreset.morningAlarms = [LDAlarm(date: morningDate)]
        alarmManager.techniquePreset.isWbtbVisible = false
        try alarmManager.setAlarms()
        let expectedDates = [dateFormatter.string(from: morningDate)]
        XCTAssert(alarmManager.runningAlarms.map {dateFormatter.string(from: $0.date )}
            .elementsEqual(expectedDates))
    }
}
