//
//  LucifyTests.swift
//  LucifyTests
//
//  Created by Patrick Elfert on 21.05.22.
//

import XCTest
@testable import Lucify
import Combine

class AlarmManagerTests: XCTestCase {
    var alarmManager = AlarmManager()
    let dateFormatter = ISO8601DateFormatter()
    var wbtbDate: Date!
    var morningDate: Date!
    private var cancelables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        cancelables = []
        wbtbDate = "2022-09-04T04:10Z".toDate(.isoDateTime)
        morningDate = "2022-09-04T06:10Z".toDate(.isoDateTime)
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_creates_all_rausis_alarms() throws {
        let rausisPreset = RausisPreset()
        
        let alarmPublisher = rausisPreset.$allAlarms.dropFirst(2).first()
    
        rausisPreset.wbtbAlarms = [LDAlarm(date: wbtbDate)]
        rausisPreset.morningAlarms = [LDAlarm(date: morningDate)]
        
        let expectedDates = [dateFormatter.string(from: wbtbDate),
                             dateFormatter.string(from: wbtbDate.addingTimeInterval(2.minutes)),
                             dateFormatter.string(from: wbtbDate.addingTimeInterval(4.minutes)),
                             dateFormatter.string(from: morningDate)]
        
        let allAlarms = try awaitPublisher(alarmPublisher)
        print(allAlarms)
        alarmManager.setAlarms(alarms: allAlarms)
        
        XCTAssert(alarmManager.runningAlarms.map {dateFormatter.string(from: $0.date )}
            .elementsEqual(expectedDates))
    }
    
    func test_reset_alarms() throws {
        alarmManager.runningAlarms = [LDAlarm(fromNow: 1.hours)]
        alarmManager.cancelAlarms()
        XCTAssert(alarmManager.runningAlarms.isEmpty)
    }
    
}

extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )
        waitForExpectations(timeout: timeout)
        cancellable.cancel()
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )
        return try unwrappedResult.get()
    }
}
