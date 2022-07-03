//
//  ExpandablePickerView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 03.07.22.
//

import SwiftUI

struct ExpandablePickerView<Content: View>: View {
    var systemName: String
    var title: String
    var footNote: String
    @Binding var enabled: Bool
    @ViewBuilder var content: Content
    @State var isClicked: Bool = false

    var body: some View {
        Toggle(isOn: Binding(get: { enabled }, set: { enabled = $0; if $0 == true { isClicked = false }})) {
            Image(systemName: systemName).foregroundColor(Color("Primary"))
            HStack {
                VStack(alignment: .leading) {
                    Text("Chaining")
                    if enabled {
                        Text(footNote)
                            .font(.footnote)
                            .padding(.leading, 2)
                            .foregroundColor(Color("Primary"))
                    }
                }
                Spacer()
            }.onTapGesture {
                withAnimation(.easeInOut) {
                    isClicked.toggle()
                }
            }
        }.tint(Color("Primary"))
        if enabled && isClicked {
            content
        }
    }
}

struct ExpandablePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandablePickerView(systemName: "repeat.circle.fill", title: "Chaining", footNote: "4 times", enabled: .constant(true)) {
            Picker("Number of alarms", selection: .constant(2)) {
                Text("2").tag(2)
                Text("4").tag(4)
                Text("6").tag(6)
            }.pickerStyle(.segmented)
        }
    }
}
