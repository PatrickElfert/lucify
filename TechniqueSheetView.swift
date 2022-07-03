//
//  TechniqueSheetView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 16.06.22.
//

import SwiftUI

struct TechniqueSheetView: View {
    @Binding var selectedTechnique: Technique
    @State var allAlarms: [LDAlarm] = []
    var onConfirm: ([LDAlarm]) -> Void

    var body: some View {
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
    }
}

struct TechniqueSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueSheetView(selectedTechnique: .constant(Technique.RAUSIS)) {
            _ in
        }
    }
}
