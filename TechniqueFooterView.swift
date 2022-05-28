//
//  SaveTechniqueView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 28.05.22.
//

import SwiftUI

struct TechniqueFooterView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    var allAlarms: [LDAlarm]
    
    var body: some View {
        NavigationLink(destination: AlarmView().environmentObject(alarmManager).onAppear {alarmManager.setAlarms(alarms: allAlarms)}) {
            Label("Set Alarms", systemImage: "Clock")
        }
    }
}

struct SaveTechniqueView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueFooterView(allAlarms: []).environmentObject(AlarmManager())
    }
}
