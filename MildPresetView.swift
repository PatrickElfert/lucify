//
//  MildPresetView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import Combine
import SwiftUI

struct MildPresetView: View {
    @Binding var allAlarms: [LDAlarm]
    @ObservedObject var mildPreset = MildViewModel()
    @State var anyCancallable: AnyCancellable = AnyCancellable {}

    var body: some View {
        List {
            Toggle("Combine MILD with WBTB", isOn: $mildPreset.isWbtbEnabled.animation()).tint(Primary)
            if mildPreset.isWbtbEnabled {
                DatePicker(selection: $mildPreset.wbtbAlarms[0].date, displayedComponents: [.hourAndMinute]) {
                    Image(systemName: "moon.stars.fill").foregroundColor(Primary)
                    Text("WBTB")
                }.datePickerStyle(.graphical)
            }
            Section {
                ForEach($mildPreset.morningAlarms) {
                    $alarm in
                    DatePicker(selection: $alarm.date, displayedComponents: [.hourAndMinute]) {
                        Image(systemName: "sun.and.horizon.fill").foregroundColor(Primary)
                        Text("Morning")
                    }.datePickerStyle(.graphical)
                }
            }
        }
        .onAppear {
            anyCancallable = mildPreset.$allAlarms.assign(to: \.allAlarms, on: self)
        }.onDisappear {
            anyCancallable.cancel()
        }.listStyle(.insetGrouped)
    }
}

struct MildPresetView_Previews: PreviewProvider {
    static var previews: some View {
        MildPresetView(allAlarms: .constant([])).environment(\.colorScheme, .dark)
    }
}
