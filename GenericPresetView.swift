//
//  GenericPresetView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import SwiftUI

struct GenericPresetView: View {
    @ObservedObject var genericPreset: TechniquePreset
    var body: some View {
        List {
            Section(header: Text("WBTB")) {
                ForEach($genericPreset.wbtbAlarms) {
                    $alarm in
                    DatePicker("", selection: $alarm.date ).labelsHidden()
                }
            }
            Section(header: Text("Morning")) {
                ForEach($genericPreset.morningAlarms) {
                    $alarm in
                    DatePicker("", selection: $alarm.date ).labelsHidden()
                }
            }
            TechniqueFooterView(allAlarms: genericPreset.allAlarms)
        }.listStyle(.automatic)
    }
}

struct GenericPresetView_Previews: PreviewProvider {
    static var previews: some View {
        GenericPresetView(genericPreset: TechniquePreset(type: .SSILD)).environmentObject(AlarmManager())
    }
}
