//
//  DatePickerManager.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 26.06.22.
//

import Foundation

class DatePickerManager: ObservableObject {
    @Published var shownWeeks: [[Date]] = []
    var currentIndex = 0
    private let dateGenerator: () -> Date
    private var isFirst: Bool = true

    init(dateGenerator: @escaping () -> Date = Date.init) {
        self.dateGenerator = dateGenerator
        shownWeeks = buildWeeks()
    }

    func buildWeeks() -> [[Date]] {
        (-1 ... 1).map {
            week in
            buildWeekDays(index: week)
        }
    }

    func buildWeekDays(index: Int) -> [Date] {
        (0 ... 6).map {
            day in dateGenerator().addingTimeInterval(index.weeks).addingTimeInterval(day.days)
        }
    }

    func onWeekChange(index: Int) {
        if index == 0 {
            loadPreviousWeek()
        } else if index == 2 {
            loadNextWeek()
        }
    }

    func loadNextWeek() {
        currentIndex += isFirst ? 2 : 1
        shownWeeks.removeFirst()
        shownWeeks.append(buildWeekDays(index: currentIndex))
        isFirst = false
    }

    func loadPreviousWeek() {
        currentIndex -= isFirst ? 2 : 1
        shownWeeks.removeLast()
        shownWeeks.insert(buildWeekDays(index: currentIndex), at: 0)
        isFirst = false
    }
}
