//
//  GenericPresetView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import SwiftUI
import Combine

struct GenericPresetView: View {
    @ObservedObject var genericPreset: TechniquePreset
    @State var anyCancallable: AnyCancellable = AnyCancellable() {}
    @Binding var allAlarms: [LDAlarm]
    
    var body: some View {
        List {
            Section {
                ForEach($genericPreset.wbtbAlarms) {
                    $alarm in
                    DatePicker(selection: $alarm.date, displayedComponents: [.hourAndMinute]) {
                        Image(systemName: "moon.stars.fill").foregroundColor(Color("Primary"))
                        Text("WBTB")
                    }.datePickerStyle(.graphical)
                }
            }
            Section {
                ForEach($genericPreset.morningAlarms) {
                    $alarm in
                    DatePicker(selection: $alarm.date, displayedComponents: [.hourAndMinute]) {
                        Image(systemName: "sun.and.horizon.fill").foregroundColor(Color("Primary"))
                        Text("Morning")
                    }.datePickerStyle(.graphical)                }
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
        GenericPresetView(genericPreset: TechniquePreset(type: .SSILD), allAlarms: .constant([]))
    }
}
