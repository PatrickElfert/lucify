//
//  TechniqueSelectionView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 28.05.22.
//

import SwiftUI

struct TechniqueSelectionView: View {
    var selectedTechnique: Technique
    var body: some View {
        switch selectedTechnique {
        case .RAUSIS:
            RausisPresetView()
        case .FILD:
            GenericPresetView(genericPreset: TechniquePreset(type: .FILD))
        case .MILD:
            MildPresetView()
        case .SSILD:
            GenericPresetView(genericPreset: TechniquePreset(type: .SSILD))
        }
    }
}

struct TechniqueSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueSelectionView(selectedTechnique: .RAUSIS).environmentObject(AlarmManager())
    }
}
