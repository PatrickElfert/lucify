//
//  DreamDiaryManagerTests.swift
//  LucifyTests
//
//  Created by Patrick Elfert on 19.06.22.
//

@testable import Lucify
import XCTest

class DreamDiaryManagerTests: XCTestCase {
    var dreamDiaryManager: DreamDiaryManager!

    override func setUpWithError() throws {
        dreamDiaryManager = DreamDiaryManager()
    }

    override func tearDownWithError() throws {}

    func test_add_and_read_entries() throws {
        let expectedEntries = [DiaryEntryModel(date: "2022-09-04T17:10Z".toDate(.isoDateTime)!, title: "TestTitle", description: "TestDescription", isLucid: true)]
        dreamDiaryManager.addEntries(date: "2022-09-04".toDate(.isoDate)!, newEntries: expectedEntries)
        dreamDiaryManager.loadEntries(date: "2022-09-04".toDate(.isoDate)!)
        XCTAssertTrue(dreamDiaryManager.entries[0].date == expectedEntries[0].date)
        XCTAssertTrue(dreamDiaryManager.entries[0].title == expectedEntries[0].title)
        XCTAssertTrue(dreamDiaryManager.entries[0].description == expectedEntries[0].description)
        XCTAssertTrue(dreamDiaryManager.entries[0].isLucid == expectedEntries[0].isLucid)
    }
}
