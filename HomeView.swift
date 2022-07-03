//
//  HomeView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 19.06.22.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.scenePhase) var scenePhase
    @State var selectedTechnique: Technique = .MILD
    @State private var isPresented: Bool = false
    @State private var allAlarms: [LDAlarm] = []
    @State private var alarmsActive = false
    @ObservedObject var alarmManager: AlarmManager = .init()

    func onTechniqueClicked(type: Technique) {
        selectedTechnique = type
        isPresented = true
    }

    var body: some View {
        ZStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    /* HStack {
                     Text("Your Progress")
                     .font(Font.largeTitle.weight(.bold))
                     .padding(.top)
                     .padding(.leading)
                     Spacer()
                     }
                     HStack {
                     StatisticCardView(title: "Lucid Dreams", count: 20)
                     StatisticCardView(title: "Normal Dreams", count: 20)
                     } */
                    HStack {
                        Text("Start dreaming")
                            .font(Font.largeTitle.weight(.bold))
                            .padding(.top)
                            .padding(.leading)
                        Spacer()
                    }
                    ForEach(Technique.allCases, id: \.rawValue) {
                        technique in
                        TechniqueCardView(type: technique, description: technique.description, onClick: onTechniqueClicked)
                    }
                    Spacer()
                }
            }
            .background(Color("Home Overlay")).cornerRadius(radius: 17, corners: [.topLeft, .topRight])
            .sheet(isPresented: $alarmsActive) {
                AlarmView().environmentObject(alarmManager).onAppear {
                    isPresented = false
                }.environment(\.scenePhase, scenePhase)
            }.sheet(isPresented: $isPresented) {
                TechniqueSheetView(selectedTechnique: $selectedTechnique) {
                    alarms in alarmManager.setAlarms(alarms: alarms)
                    alarmsActive = true
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AlarmManager())
    }
}
