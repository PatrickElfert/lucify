//
//  TechniqueSelectionView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 28.05.22.
//

import SwiftUI

struct TechniqueSelectionView: View {
    @Binding var selectedTechnique: Technique
    @Binding var allAlarms: [LDAlarm]

    var body: some View {
        switch selectedTechnique {
        case .RAUSIS:
            RausisPresetView(allAlarms: $allAlarms)
        case .MILD:
            MildPresetView(allAlarms: $allAlarms)
        default:
            GenericPresetView(genericPreset: GenericTechniqueViewModel(type: selectedTechnique), allAlarms: $allAlarms)
        }
    }
}

struct TechniqueSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueSelectionView(selectedTechnique: .constant(.RAUSIS), allAlarms: .constant([])).environmentObject(AlarmManager())
    }
}
