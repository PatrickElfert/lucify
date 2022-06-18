//
//  AlarmTimeLineView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 16.06.22.
//

import SwiftUI

struct AlarmTimeLineView: View {
    @Binding var runningAlarms: [LDAlarm]
    var body: some View {
        VStack(spacing: 5) {
            ForEach(runningAlarms) {
                alarm in
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        VStack {
                            Image(systemName: runningAlarms.last?.id == alarm.id ? "sun.and.horizon.fill" : "moon.stars.fill")
                        }.frame(width: 40, height: 40).background(Color("Primary")).cornerRadius(5)
                        Text(alarm.date.toString(.custom("hh:mm a"))!).fontWeight(.semibold)
                    }
                    if runningAlarms.last?.id != alarm.id {
                        VStack(alignment: .center) {
                            Rectangle()
                                .frame(width: 5, height: 70)
                                .cornerRadius(5)
                                .foregroundColor(Color("Primary")).opacity(0.5)
                        }.frame(width: 40)
                    }
                }
            }
        }
    }
}

struct AlarmTimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmTimeLineView(runningAlarms: .constant([LDAlarm(fromNow: 9.hours), LDAlarm(fromNow: 6.hours)]))
    }
}
