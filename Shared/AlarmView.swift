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
                    ForEach(alarmManager.runningAlarms) {
                        alarm in
                        Text(alarm.date.toString(.custom("HH:mm"))!)
                    }
                }.navigationTitle("Alarms")
                Button("Cancel") {
                    alarmManager.cancelAlarms()
                    dismiss()
                }
            }
        }.navigationBarBackButtonHidden(true)    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        let alarms = [LDAlarm(fromNow: 8.hours)]
        AlarmView().environmentObject(AlarmManager())
    }
}
