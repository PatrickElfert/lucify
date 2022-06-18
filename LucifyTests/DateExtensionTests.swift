//
//  DateExtensionTests.swift
//  LucifyTests
//
//  Created by Patrick Elfert on 18.06.22.
//

import XCTest

class DateExtensionTests: XCTestCase {
    var testDateComponent = DateComponents()
    var date: Date!
    let dateFormatter = ISO8601DateFormatter()

    override func setUpWithError() throws {
        date = "2022-09-04T17:10Z".toDate(.isoDateTime)
    }

    func test_is_after_time_today() throws {
        let today = "2022-09-03T16:10Z".toDate(.isoDateTime)
        XCTAssertTrue(date!.isAfterTimeToday(date: today!))
    }

    func test_is_not_after_time_today() throws {
        let today = "2022-09-03T18:10Z".toDate(.isoDateTime)
        XCTAssertFalse(date!.isAfterTimeToday(date: today!))
    }

    func test_time_in_today() {
        let today = "2022-09-03T16:10Z".toDate(.isoDateTime)
        let adjustedDate = date.time(in: today!)
        let expectedDate = "2022-09-03T17:10Z".toDate(.isoDateTime)!
        XCTAssertTrue(expectedDate.toString(.isoDateTime) == adjustedDate.toString(.isoDateTime))
    }

    func test_time_not_in_today() {
        let today = "2022-09-03T18:10Z".toDate(.isoDateTime)
        let adjustedDate = date.time(in: today!)
        XCTAssertTrue(date.toString(.isoDateTime) == adjustedDate.toString(.isoDateTime))
    }

    func test_time_not_in_today_same_day() {
        let today = "2022-09-03T18:10Z".toDate(.isoDateTime)
        let sameDay = "2022-09-03T17:10Z".toDate(.isoDateTime)
        let adjustedDate = sameDay!.time(in: today!)
        XCTAssertTrue(date.toString(.isoDateTime) == adjustedDate.toString(.isoDateTime))
    }
}
