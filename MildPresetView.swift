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
        Form {
            Toggle("Combine MILD with WBTB", isOn: $mildPreset.isWbtbEnabled).tint(Color("Primary"))
            if(mildPreset.isWbtbEnabled) {
                Section(header: SectionHeader(text: "WBTB")) {
                    ForEach($mildPreset.wbtbAlarms) {
                        $alarm in
                        DatePicker("", selection: $alarm.date ).labelsHidden()
                    }
                }
            }
            Section(header: SectionHeader(text: "Morning")) {
                ForEach($mildPreset.morningAlarms) {
                    $alarm in
                    DatePicker("", selection: $alarm.date ).labelsHidden()
                }
            }
        }
    }
}

struct MildPresetView_Previews: PreviewProvider {
    static var previews: some View {
        MildPresetView().environmentObject(AlarmManager())}
}

struct SectionHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundColor(Color("Primary"))
    }
}
