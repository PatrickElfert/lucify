//
//  DatePickerManagerTests.swift
//  LucifyTests
//
//  Created by Patrick Elfert on 27.06.22.
//

@testable import Lucify
import XCTest

class DatePickerManagerTests: XCTestCase {
    var datePickerManager: DatePickerManager!

    override func setUpWithError() throws {
        print("2022-09-03".toDate(.isoDate)!)
        datePickerManager = DatePickerManager { "2022-09-03".toDate(.isoDate)! }
    }

    func test_initial_weeks() throws {
        let initialWeeks: [[String]] = [
            ["2022-08-27",
             "2022-08-28",
             "2022-08-29",
             "2022-08-30",
             "2022-08-31",
             "2022-09-01",
             "2022-09-02"],
            ["2022-09-03",
             "2022-09-04",
             "2022-09-05",
             "2022-09-06",
             "2022-09-07",
             "2022-09-08",
             "2022-09-09"],
            ["2022-09-10",
             "2022-09-11",
             "2022-09-12",
             "2022-09-13",
             "2022-09-14",
             "2022-09-15",
             "2022-09-16"],
        ]
        XCTAssertEqual(datePickerManager.shownWeeks.map { $0.map { $0.toString(.isoDate)! }}, initialWeeks)
    }

    func test_previous_weeks() throws {
        let withPreviousWeek: [[String]] = [
            ["2022-08-20",
             "2022-08-21",
             "2022-08-22",
             "2022-08-23",
             "2022-08-24",
             "2022-08-25",
             "2022-08-26"],
            ["2022-08-27",
             "2022-08-28",
             "2022-08-29",
             "2022-08-30",
             "2022-08-31",
             "2022-09-01",
             "2022-09-02"],
            ["2022-09-03",
             "2022-09-04",
             "2022-09-05",
             "2022-09-06",
             "2022-09-07",
             "2022-09-08",
             "2022-09-09"],
        ]
        datePickerManager = DatePickerManager { "2022-09-03".toDate(.isoDate)! }
        datePickerManager.onWeekChange(index: 0)

        XCTAssertEqual(datePickerManager.shownWeeks.map { $0.map { $0.toString(.isoDate)! }}, withPreviousWeek)
    }

    func test_adding_weeks() throws {
        let withNextWeek: [[String]] = [
            ["2022-09-03",
             "2022-09-04",
             "2022-09-05",
             "2022-09-06",
             "2022-09-07",
             "2022-09-08",
             "2022-09-09"],
            ["2022-09-10",
             "2022-09-11",
             "2022-09-12",
             "2022-09-13",
             "2022-09-14",
             "2022-09-15",
             "2022-09-16"],
            ["2022-09-17",
             "2022-09-18",
             "2022-09-19",
             "2022-09-20",
             "2022-09-21",
             "2022-09-22",
             "2022-09-23"],
        ]
        datePickerManager = DatePickerManager { "2022-09-03".toDate(.isoDate)! }
        datePickerManager.onWeekChange(index: 2)

        XCTAssertEqual(datePickerManager.shownWeeks.map { $0.map { $0.toString(.isoDate)! }}, withNextWeek)
    }

    func test_adding_more_then_one_weeks() throws {
        let withNextWeeks: [[String]] = [
            ["2022-09-10",
             "2022-09-11",
             "2022-09-12",
             "2022-09-13",
             "2022-09-14",
             "2022-09-15",
             "2022-09-16"],
            ["2022-09-17",
             "2022-09-18",
             "2022-09-19",
             "2022-09-20",
             "2022-09-21",
             "2022-09-22",
             "2022-09-23"],
            ["2022-09-24",
             "2022-09-25",
             "2022-09-26",
             "2022-09-27",
             "2022-09-28",
             "2022-09-29",
             "2022-09-30"],
        ]
        datePickerManager = DatePickerManager { "2022-09-03".toDate(.isoDate)! }
        datePickerManager.onWeekChange(index: 2)
        datePickerManager.onWeekChange(index: 2)

        XCTAssertEqual(datePickerManager.shownWeeks.map { $0.map { $0.toString(.isoDate)! }}, withNextWeeks)
    }
}
