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
        case .FILD:
            GenericPresetView(genericPreset: TechniquePreset(type: .FILD), allAlarms: $allAlarms)
        case .MILD:
            MildPresetView(allAlarms: $allAlarms)
        case .SSILD:
            GenericPresetView(genericPreset: TechniquePreset(type: .SSILD), allAlarms: $allAlarms)
        case .WILD:
            GenericPresetView(genericPreset: TechniquePreset(type: .WILD), allAlarms: $allAlarms)
        }
    }
}

struct TechniqueSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueSelectionView(selectedTechnique: .constant(.RAUSIS), allAlarms: .constant([])).environmentObject(AlarmManager())
    }
}
