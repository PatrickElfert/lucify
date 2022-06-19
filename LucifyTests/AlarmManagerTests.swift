//
//  LucifyTests.swift
//  LucifyTests
//
//  Created by Patrick Elfert on 21.05.22.
//

import Combine
@testable import Lucify
import XCTest

class AlarmManagerTests: XCTestCase {
    var alarmManager = AlarmManager {
        "2022-09-03T16:10Z".toDate(.isoDateTime)!
    }

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

    override func tearDownWithError() throws {}

    func test_creates_alarms_in_same_day() throws {
        let mildPreset = MildViewModel()
        let alarmPublisher = mildPreset.$allAlarms.dropFirst(2).first()
        let tomorrow = "2022-09-04T17:11Z".toDate(.isoDateTime)!
        let expectedDate = "2022-09-03T17:11Z".toDate(.isoDateTime)!

        mildPreset.isWbtbEnabled = false
        mildPreset.morningAlarms = [LDAlarm(date: tomorrow)]

        let expectedDates = [expectedDate.toString(.isoDateTime)]
        let allAlarms = try awaitPublisher(alarmPublisher)
        alarmManager.setAlarms(alarms: allAlarms)
        XCTAssert(alarmManager.runningAlarms.map { $0.date.toString(.isoDateTime) }.elementsEqual(expectedDates))
    }

    func test_creates_all_rausis_alarms() throws {
        let rausisPreset = RausisViewModel()

        let alarmPublisher = rausisPreset.$allAlarms.dropFirst(2).first()

        rausisPreset.wbtbAlarms = [LDAlarm(date: wbtbDate)]
        rausisPreset.morningAlarms = [LDAlarm(date: morningDate)]

        let expectedDates = [wbtbDate.toString(.isoDateTime),
                             wbtbDate.addingTimeInterval(2.minutes).toString(.isoDateTime),
                             wbtbDate.addingTimeInterval(4.minutes).toString(.isoDateTime),
                             morningDate.toString(.isoDateTime)]

        let allAlarms = try awaitPublisher(alarmPublisher)
        alarmManager.setAlarms(alarms: allAlarms)

        XCTAssert(alarmManager.runningAlarms.map { $0.date.toString(.isoDateTime) }
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
                case let .failure(error):
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
