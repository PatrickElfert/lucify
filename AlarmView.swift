//
//  AlarmView.swift
//  Lucify
//
//  Created by Patrick Elfert on 22.05.22.
//

import SwiftUI

struct AlarmView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    @ObservedObject var notificationManager = NotificationManager.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section("Active") {
                        ForEach(alarmManager.runningAlarms) {
                            alarm in
                            HStack() {
                                Text(alarm.date.toString(.custom("hh:mm a"))!)
                                Spacer()
                                alarm.isCompleted ? Image(systemName: "checkmark.square.fill") : Image(systemName: "checkmark.square")
                                
                            }
                        }
                    }
                    Label("Cancel", systemImage: "xmark.square.fill").onTapGesture {
                        alarmManager.cancelAlarms()
                        dismiss()
                    }
                }.navigationTitle("Alarms")
            }.alert("Alarm", isPresented: $notificationManager.isNotificationActive) {
                Button("Ok") {
                    notificationManager.isNotificationActive = false
                    if let uuidString = notificationManager.currentNotificationIdentifier {
                        alarmManager.completeAlarm(uuid: uuidString)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView().environmentObject(AlarmManager(runningAlarms: [LDAlarm(fromNow: 9.hours), LDAlarm(fromNow: 6.hours)]))
    }
}
