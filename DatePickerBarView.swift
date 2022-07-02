//
//  DatePickerBarView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 25.06.22.
//

import SwiftUI

struct DatePickerBarView: View {
    @Binding var selectedDay: Date
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
                        Spacer()
                        DatePickerElement(date: day, isSelected: Calendar.current.isDate(selectedDay, equalTo: day, toGranularity: .day)).onTapGesture {
                            selectedDay = day
                        }
                    }
                    Spacer()
                }.onChange(of: currentPage) {
                    _ in
                    datePickerManager.onWeekChange(index: currentPage)
                    currentPage = 1
                }
            }
        }.frame(height: 70)
    }
}

struct DatePickerBarView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerBarView(selectedDay: .constant(Date.now))
    }
}

struct DatePickerElement: View {
    init(date: Date, isSelected: Bool) {
        self.date = date
        self.isSelected = isSelected
    }

    let isSelected: Bool
    let date: Date

    var body: some View {
        VStack {
            Text("\(date.toString(.custom("dd"))!)").font(Font.body).fontWeight(.bold)
            if isSelected {
                Text("\(date.toString(.custom("EEE"))!)").font(Font.caption).opacity(0.8)
            } else {
                Text("\(date.toString(.custom("EEE"))!)").font(Font.caption).opacity(0.8)
            }
        }.frame(width: 40, height: 40).background(isSelected ? Color("Selection") : Color("Primary")).cornerRadius(10).foregroundColor(isSelected ? .black : .white)
    }
}
