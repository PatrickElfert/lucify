//
//  DatePickerManager.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 26.06.22.
//

import Foundation

class DatePickerManager: ObservableObject {
    @Published var shownWeeks: [[Date]] = []

    init() {
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
            day in Date.now.addingTimeInterval(index.weeks).addingTimeInterval(day.days)
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
        shownWeeks.removeFirst()
        shownWeeks.append(buildWeekDays(index: 2))
    }

    func loadPreviousWeek() {
        shownWeeks.removeLast()
        shownWeeks.insert(buildWeekDays(index: 0), at: 0)
    }
}
