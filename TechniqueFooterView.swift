//
//  SaveTechniqueView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 28.05.22.
//

import SwiftUI
import UserNotifications

struct TechniqueFooterView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    var allAlarms: [LDAlarm]
    
    var body: some View {
        NavigationLink(destination: AlarmView()
            .onAppear {
                alarmManager.setAlarms(alarms: allAlarms)
            }
            .environmentObject(alarmManager)
        ) {
            Label("Set Alarms", systemImage: "clock.badge.checkmark.fill")
        }    }
}

struct SaveTechniqueView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueFooterView(allAlarms: []).environmentObject(AlarmManager())
    }
}
