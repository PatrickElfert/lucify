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
        VStack {
            HStack {
                Text("Alarms")
                    .font(Font.largeTitle.weight(.bold))
                    .padding(.top)
                    .padding(.leading)
                Spacer()
            }
            HStack {
                AlarmTimeLineView(runningAlarms: $alarmManager.runningAlarms)
                    .alert("Are you dreaming?", isPresented: $notificationManager.isNotificationActive) {
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
                            if alarmManager.allAlarmsCompleted {
                                dismiss()
                            }
                        }
                    }.interactiveDismissDisabled()
                    .padding(.leading, 10)
                Spacer()
            }.padding(.leading)
            Spacer()
            Button(action: { alarmManager.cancelAlarms(); dismiss() }) {
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: "clear.fill")
                    Text("Stop")
                }.frame(maxWidth: .infinity, maxHeight: 50)
            }.frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color("Primary"))
                .cornerRadius(5)
                .foregroundColor(.primary).padding()
        }
        .onChange(of: scenePhase) { newPhase in
            print("scene phase")
            print(newPhase)
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
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(isDreamDiaryVisible: false).environmentObject(AlarmManager(runningAlarms: [LDAlarm(fromNow: 9.hours), LDAlarm(fromNow: 6.hours)]))
    }
}
