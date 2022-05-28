//
//  AlarmView.swift
//  Lucify
//
//  Created by Patrick Elfert on 21.05.22.
//

import SwiftUI

struct TechniquesView: View {
    
    @ObservedObject var alarmManager: AlarmManager = AlarmManager()
    @State var selectedTechnique: Technique = .RAUSIS
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Technique", selection: $selectedTechnique) {
                    ForEach(Technique.allCases, id: \.rawValue) {
                        technique in
                        Text(technique.rawValue).tag(technique)
                    }
                }
                .padding(.horizontal)
                .pickerStyle(.segmented)
                TechniqueSelectionView(selectedTechnique: selectedTechnique).environmentObject(alarmManager)
                Spacer().navigationTitle("Techniques")
            }
        }
    }
    
}

struct AlarmEditView_Previews: PreviewProvider {
    static var previews: some View {
        TechniquesView().environmentObject(AlarmManager())
    }
}

