//
//  LucifyTests.swift
//  LucifyTests
//
//  Created by Patrick Elfert on 21.05.22.
//

import XCTest
@testable import Lucify

class LucifyTests: XCTestCase {
    var alarmManager = AlarmManager()
    
    override func setUpWithError() throws {
        alarmManager.selectedMethod = .RAUSIS
        alarmManager.setTechniquePreset(technique: .RAUSIS)
        alarmManager.numberOfRausisAlarms = 4
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_creates_all_alarms() throws {
        try alarmManager.setAlarms()
        print(alarmManager.runningAlarms.map{$0.date})
        XCTAssert(alarmManager.runningAlarms.count > 0, "Not all alarms are created")
    }
}
