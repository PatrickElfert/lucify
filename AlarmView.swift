//
//  AlarmView.swift
//  Lucify
//
//  Created by Patrick Elfert on 22.05.22.
//

import SwiftUI

struct AlarmView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section("Active") {
                        ForEach(alarmManager.runningAlarms) {
                            alarm in
                            Text(alarm.date.toString(.custom("hh:mm a"))!)
                        }
                    }
                    Label("Cancel", systemImage: "xmark.square.fill").onTapGesture {
                        alarmManager.cancelAlarms()
                        dismiss()
                    }
                }.navigationTitle("Alarms")
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView().environmentObject(AlarmManager(runningAlarms: [LDAlarm(fromNow: 9.hours), LDAlarm(fromNow: 6.hours)]))
    }
}
