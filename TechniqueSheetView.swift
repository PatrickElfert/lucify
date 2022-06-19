//
//  TechniqueSheetView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 16.06.22.
//

import HalfASheet
import SwiftUI

struct TechniqueSheetView: View {
    @Binding var isPresented: Bool
    @Binding var selectedTechnique: Technique
    @State var allAlarms: [LDAlarm] = []
    var onConfirm: ([LDAlarm]) -> Void

    var body: some View {
        HalfASheet(isPresented: $isPresented) {
            VStack {
                TechniqueSelectionView(selectedTechnique: $selectedTechnique, allAlarms: $allAlarms)
                Button(action: {
                    onConfirm(allAlarms)
                }) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Confirm")
                        Image(systemName: "clock.badge.checkmark.fill")
                    }.frame(maxWidth: .infinity, maxHeight: 50)
                }
                .background(Color("Primary"))
                .cornerRadius(5)
                .foregroundColor(.primary).padding()
            }
        }.height(.proportional(0.6))
            .contentInsets(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            .backgroundColor(UIColor.systemGroupedBackground)
    }
}

struct TechniqueSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueSheetView(isPresented: .constant(true), selectedTechnique: .constant(Technique.RAUSIS)) {
            _ in
        }
        .environment(\.colorScheme, .dark)
    }
}
