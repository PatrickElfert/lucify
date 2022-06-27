//
//  DatePickerBarView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 25.06.22.
//

import SwiftUI

struct DatePickerBarView: View {
    @ObservedObject var datePickerManager = DatePickerManager()
    @State private var scrollViewContentOffset = CGFloat(0)
    @State private var currentPage: Int = 1
    var body: some View {
        PagerView(pageCount: 3, currentIndex: $currentPage) {
            ForEach(datePickerManager.shownWeeks, id: \.self) {
                week in
                HStack(spacing: 0) {
                    ForEach(week, id: \.self) {
                        day in
                        DatePickerElement(date: day).padding(10)
                    }
                }.frame(height: 70).onChange(of: currentPage) {
                    _ in
                    datePickerManager.onWeekChange(index: currentPage)
                    currentPage = 1
                }
            }
        }
    }
}

struct DatePickerBarView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerBarView()
    }
}

struct DatePickerElement: View {
    init(date: Date) {
        self.date = date
        isToday = Calendar.current.isDateInToday(date)
    }

    let isToday: Bool
    let date: Date

    var body: some View {
        VStack {
            Text("\(date.toString(.custom("dd"))!)").font(Font.body).fontWeight(.bold)
            if isToday {
                Text("Today").font(Font.caption).opacity(0.8)
            } else {
                Text("\(date.toString(.custom("EEE"))!)").font(Font.caption).opacity(0.8)
            }
        }.frame(width: 40, height: 40).background(isToday ? Color("Selection") : Color("Primary")).cornerRadius(10).foregroundColor(isToday ? .black : .white)
    }
}
