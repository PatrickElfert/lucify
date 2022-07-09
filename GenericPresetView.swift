//
//  GenericPresetView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import Combine
import SwiftUI

struct GenericPresetView: View {
    @ObservedObject var genericPreset: GenericTechniqueViewModel
    @State var anyCancallable: AnyCancellable = AnyCancellable {}
    @Binding var allAlarms: [LDAlarm]

    var body: some View {
        List {
            Section {
                ForEach($genericPreset.wbtbAlarms) {
                    $alarm in
                    DatePicker(selection: $alarm.date, displayedComponents: [.hourAndMinute]) {
                        Image(systemName: "moon.stars.fill").foregroundColor(Primary)
                        Text("WBTB")
                    }.datePickerStyle(.graphical)
                }
            }
            Section {
                ForEach($genericPreset.morningAlarms) {
                    $alarm in
                    DatePicker(selection: $alarm.date, displayedComponents: [.hourAndMinute]) {
                        Image(systemName: "sun.and.horizon.fill").foregroundColor(Primary)
                        Text("Morning")
                    }.datePickerStyle(.graphical)
                }
            }
        }.listStyle(.automatic)
            .onAppear {
                anyCancallable = genericPreset.$allAlarms.assign(to: \.allAlarms, on: self)
            }.onDisappear {
                anyCancallable.cancel()
            }
    }
}

struct GenericPresetView_Previews: PreviewProvider {
    static var previews: some View {
        GenericPresetView(genericPreset: GenericTechniqueViewModel(type: .SSILD), allAlarms: .constant([]))
    }
}
