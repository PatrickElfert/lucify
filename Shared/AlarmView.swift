//
//  AlarmView.swift
//  Lucify
//
//  Created by Patrick Elfert on 22.05.22.
//

import SwiftUI

struct AlarmView: View {
    var runningAlarms: [LDAlarm]
    var body: some View {
        NavigationView {
            List {
                ForEach(runningAlarms) {
                    alarm in
                    Text(alarm.date.toString(.custom("HH:mm"))!)
                }
            }.navigationTitle("Alarms")
        }
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(runningAlarms: [LDAlarm(fromNow: 8.hours)])
    }
}
