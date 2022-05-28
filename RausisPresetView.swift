//
//  RausisView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import SwiftUI

struct RausisPresetView: View {
    @ObservedObject var rausisPreset = RausisPreset()
    
    var body: some View {
        List {
            Section(header: Text("WBTB")) {
                ForEach($rausisPreset.wbtbAlarms) {
                    $alarm in
                    DatePicker("", selection: $alarm.date ).labelsHidden()
                }
                Toggle("Chaining",isOn: $rausisPreset.isChainingEnabled.animation() )
                if(rausisPreset.isChainingEnabled) {
                    Picker("Number of alarms", selection: $rausisPreset.numberOfChainedAlarms) {
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                    }.pickerStyle(.automatic)
                }
            }
            Section(header: Text("Morning")) {
                ForEach($rausisPreset.morningAlarms) {
                    $alarm in
                    DatePicker("", selection: $alarm.date ).labelsHidden()
                }
            }
            TechniqueFooterView(allAlarms: rausisPreset.allAlarms)
        }.listStyle(.automatic)
    }
}

struct RausisView_Previews: PreviewProvider {
    static var previews: some View {
        RausisPresetView().environmentObject(AlarmManager())
    }
}
