//
//  DatePickerBarView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 25.06.22.
//

import SwiftUI

struct DatePickerBarView: View {
    var body: some View {
        let days = 365 * 50
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader {
                proxy in
                LazyHStack(spacing: 20) {
                    ForEach(1 ... days, id: \.self) {
                        DatePickerElement(date: Date.now.addingTimeInterval(Double($0) * -24.hours)).id("\($0)neg")
                    }
                    DatePickerElement(date: Date.now).id("today")
                    ForEach(1 ... days, id: \.self) {
                        DatePickerElement(date: Date.now.addingTimeInterval(Double($0) * 24.hours)).id("\($0)pos")
                    }
                }.frame(height: 70).onAppear { proxy.scrollTo("today") }
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
            Text("\(date.toString(.custom("dd"))!)").font(Font.title).fontWeight(.bold)
            if isToday {
                Text("Today").font(Font.body).opacity(0.8)
            } else {
                Text("\(date.toString(.custom("EEE"))!)").font(Font.body).opacity(0.8)
            }
        }.frame(width: 60, height: 60).background(isToday ? Color("Selection") : Color("Primary")).cornerRadius(10).foregroundColor(isToday ? .black : .white)
    }
}
