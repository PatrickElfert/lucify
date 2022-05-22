//
//  AlarmView.swift
//  Lucify
//
//  Created by Patrick Elfert on 21.05.22.
//

import SwiftUI

struct AlarmEditView: View {
    @ObservedObject var alarmManager = AlarmManager()
    @State var newAlarm = Date.now
    @State var addChaining = false
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Technique", selection: $alarmManager.selectedMethod) {
                    ForEach(Technique.allCases, id: \.rawValue) {
                        technique in
                        Text(technique.rawValue).tag(technique)
                    }
                }
                .padding(.horizontal)
                .pickerStyle(.segmented)
                .onChange(of: alarmManager.selectedMethod) { technique in
                    alarmManager.setTechniquePreset(technique: technique)
                }
                List {
                    if(alarmManager.techniquePreset.isWbtbOptional) {
                        Toggle("Combine \(alarmManager.selectedMethod.rawValue) with WBTB", isOn: $alarmManager.techniquePreset.isWbtbVisible.animation())
                    }
                    if(alarmManager.techniquePreset.isWbtbVisible) {
                        Section(header: Text("WBTB")) {
                            ForEach($alarmManager.techniquePreset.wbtbAlarms) {
                                $alarm in
                                DatePicker("", selection: $alarm.date ).labelsHidden()
                            }
                            if(alarmManager.selectedMethod == .RAUSIS) {
                                Toggle("Chaining",isOn: $addChaining)
                                if(addChaining) {
                                    Picker("Number of alarms", selection: $alarmManager.numberOfRausisAlarms) {
                                        Text("2").tag(2)
                                        Text("4").tag(4)
                                        Text("6").tag(6)
                                    }.pickerStyle(.automatic)
                                }
                            }
                        }
                    }
                    Section(header: Text("Morning")) {
                        ForEach($alarmManager.techniquePreset.morningAlarms) {
                            $alarm in
                            DatePicker("", selection: $alarm.date ).labelsHidden()
                        }
                    }
                    
                    Label(alarmManager.selectedMethod.rawValue, systemImage: "questionmark.circle")
                        .font(.caption)
                }
                .listStyle(.sidebar)
                Spacer().navigationTitle("Techniques")
                NavigationLink(destination: AlarmView(runningAlarms: alarmManager.runningAlarms)) {
                    Label("Set Alarm", systemImage: "alarm")
                }
            }
        }
    }
    
    func setAlarmAction() -> Void {
        alarmManager.setAlarms()
    }
}

struct AlarmEditView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmEditView()
    }
}

