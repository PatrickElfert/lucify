//
//  MildPresetView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import SwiftUI

struct MildPresetView: View {
    @ObservedObject var mildPreset = MildPreset()
    var body: some View {
        List {
            Toggle("Combine MILD with WBTB", isOn: $mildPreset.isWbtbEnabled)
            if(mildPreset.isWbtbEnabled) {
                Section(header: Text("WBTB")) {
                    ForEach($mildPreset.wbtbAlarms) {
                        $alarm in
                        DatePicker("", selection: $alarm.date ).labelsHidden()
                    }
                }
            }
            Section(header: Text("Morning")) {
                ForEach($mildPreset.morningAlarms) {
                    $alarm in
                    DatePicker("", selection: $alarm.date ).labelsHidden()
                }
            }
            TechniqueFooterView(allAlarms: mildPreset.allAlarms)
        }.listStyle(.automatic)
    }
}

struct MildPresetView_Previews: PreviewProvider {
    static var previews: some View {
        MildPresetView().environmentObject(AlarmManager())}
}
