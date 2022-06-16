//
//  RausisView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 27.05.22.
//

import SwiftUI
import Combine

struct RausisPresetView: View {
    @ObservedObject var rausisPreset = RausisPreset()
    @Binding var allAlarms: [LDAlarm]
    @State var anyCancallable: AnyCancellable = AnyCancellable() {}
    @State var isChainingClicked = false
    
    var body: some View {
        List {
            Section {
                ForEach($rausisPreset.wbtbAlarms) {
                    $alarm in
                    DatePicker(selection: $alarm.date, displayedComponents: [.hourAndMinute] ) {
                        Image(systemName: "moon.stars.fill").foregroundColor(Color("Primary"))
                        Text("WBTB")
                    }.datePickerStyle(.graphical)
                }
                Toggle(isOn: Binding(get: {rausisPreset.isChainingEnabled}, set: {rausisPreset.isChainingEnabled = $0; if($0 == true) {isChainingClicked = false}})) {
                    Image(systemName: "repeat.circle.fill").foregroundColor(Color("Primary"))
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Chaining")
                            if(rausisPreset.isChainingEnabled) {
                                Text("\(rausisPreset.numberOfChainedAlarms) times").font(.footnote).padding(.leading, 2).foregroundColor(Color("Primary"))
                            }
                        }
                        Spacer()
                    }.onTapGesture {
                        withAnimation(.easeInOut) {
                            isChainingClicked.toggle()
                        }
                    }
                }
                if(rausisPreset.isChainingEnabled && isChainingClicked) {
                    Picker("Number of alarms", selection: $rausisPreset.numberOfChainedAlarms) {
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                    }.pickerStyle(.segmented)
                }
            }
            ForEach($rausisPreset.morningAlarms) {
                $alarm in
                DatePicker(selection: $alarm.date, displayedComponents: [.hourAndMinute] ) {
                    Image(systemName: "sun.and.horizon.fill").foregroundColor(Color("Primary"))
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
        RausisPresetView(allAlarms: .constant([]))
    }
}
