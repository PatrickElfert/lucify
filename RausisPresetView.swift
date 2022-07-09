//
//  RausisView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import Combine
import SwiftUI

struct RausisPresetView: View {
    @ObservedObject var rausisPreset = RausisViewModel()
    @Binding var allAlarms: [LDAlarm]
    @State var anyCancallable: AnyCancellable = AnyCancellable {}
    @State var isChainingClicked = false

    var body: some View {
        List {
            Section {
                ForEach($rausisPreset.wbtbAlarms) {
                    $alarm in
                    DatePicker(selection: $alarm.date, displayedComponents: [.hourAndMinute]) {
                        Image(systemName: "moon.stars.fill").foregroundColor(Primary)
                        Text("WBTB")
                    }.datePickerStyle(.graphical)
                }
                ExpandablePickerView(systemName: "repeat.circle.fill", title: "Chaining", footNote: " \(rausisPreset.numberOfChainedAlarms) times. Turn off after \(rausisPreset.turnOfAfterSeconds) sec", enabled: $rausisPreset.isChainingEnabled) {
                    Picker("Number of alarms", selection: $rausisPreset.numberOfChainedAlarms) {
                        Text("2 times").tag(2)
                        Text("4 times").tag(4)
                        Text("6 times").tag(6)
                    }.pickerStyle(.segmented)
                    Picker("Time between alarms", selection: $rausisPreset.turnOfAfterSeconds) {
                        Text("30 sec").tag(30)
                        Text("60 sec").tag(60)
                        Text("90 sec").tag(90)
                    }.pickerStyle(.segmented)
                }
            }
            ForEach($rausisPreset.morningAlarms) {
                $alarm in
                DatePicker(selection: $alarm.date, displayedComponents: [.hourAndMinute]) {
                    Image(systemName: "sun.and.horizon.fill").foregroundColor(Primary)
                    Text("Morning")
                }.datePickerStyle(.graphical)
            }
        }.listStyle(.automatic)
            .onAppear {
                anyCancallable = rausisPreset.$allAlarms.assign(to: \.allAlarms, on: self)
            }.onDisappear {
                anyCancallable.cancel()
            }
    }
}

struct RausisView_Previews: PreviewProvider {
    static var previews: some View {
        RausisPresetView(allAlarms: .constant([])).preferredColorScheme(.dark)
    }
}
