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
    @Environment(\.scenePhase) var scenePhase
    @State var isDreamDiaryVisible = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section("Scheduled") {
                        ForEach(alarmManager.runningAlarms) {
                            alarm in
                            HStack() {
                                Text(alarm.date.toString(.custom("hh:mm a"))!)
                                Spacer()
                                alarm.isCompleted ? Image(systemName: "checkmark.square.fill") : Image(systemName: "timer.square")
                                
                            }
                        }
                    }
                    Label("Cancel", systemImage: "xmark.square.fill").onTapGesture {
                        alarmManager.cancelAlarms()
                        dismiss()
                    }
                }
                .navigationTitle("Alarms")
            }.alert("Are you dreaming?", isPresented: $notificationManager.isNotificationActive) {
                Button("No") {
                    if let uuidString = notificationManager.currentNotificationIdentifier {
                        alarmManager.completeAlarm(uuid: uuidString)
                        notificationManager.isNotificationActive = false
                        notificationManager.removeNotifications([uuidString])
                        isDreamDiaryVisible = true
                    }
                }
            }.sheet(isPresented: $isDreamDiaryVisible) {
                DreamDiarySheetView(forAlarmDate: Date.now).onDisappear {
                    if(alarmManager.allAlarmsCompleted) {
                        dismiss()
                    }
                }
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                let runningAlarm = alarmManager.runningAlarms.first {
                    $0.audioPlayer!.isPlaying
                }
                if let alarmToComplete = runningAlarm {
                    alarmManager.completeAlarm(uuid: alarmToComplete.id.uuidString)
                    isDreamDiaryVisible = true
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(isDreamDiaryVisible:true).environmentObject(AlarmManager(runningAlarms: [LDAlarm(fromNow: 9.hours), LDAlarm(fromNow: 6.hours)]))
    }
}
