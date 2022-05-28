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
        let rausisPreset = RausisPreset()
        rausisPreset.wbtbAlarms = [LDAlarm(date: wbtbDate)]
        rausisPreset.morningAlarms = [LDAlarm(date: morningDate)]
        alarmManager.setAlarms(alarms: rausisPreset.allAlarms)
        print(rausisPreset.allAlarms)
        let expectedDates = [dateFormatter.string(from: wbtbDate),
                            dateFormatter.string(from: wbtbDate.addingTimeInterval(2.minutes)),
                            dateFormatter.string(from: wbtbDate.addingTimeInterval(4.minutes)),
                            dateFormatter.string(from: morningDate)]
        XCTAssert(alarmManager.runningAlarms.map {dateFormatter.string(from: $0.date )}
            .elementsEqual(expectedDates))
    }
    
    func test_reset_alarms() throws {
        alarmManager.runningAlarms = [LDAlarm(fromNow: 1.hours)]
        alarmManager.cancelAlarms()
        XCTAssert(alarmManager.runningAlarms.isEmpty)
    }

}
