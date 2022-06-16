//
//  AlarmView.swift
//  Lucify
//
//  Created by Patrick Elfert on 21.05.22.
//

import SwiftUI
import HalfASheet

struct TechniquesView: View {
    
    @ObservedObject var alarmManager: AlarmManager = AlarmManager()
    @ObservedObject var notificationManager: NotificationManager = NotificationManager()
    @State var selectedTechnique: Technique = .MILD
    @State private var isPresented: Bool = false
    @State private var allAlarms: [LDAlarm] = []
    @State private var alarmsActive = false
    
    var body: some View {
        NavigationLink("", isActive: $alarmsActive) { AlarmView().environmentObject(alarmManager) }
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "bed.double.circle.fill").font(.title).padding(.leading, 10).foregroundColor(.white)
                    Spacer()
                    Text("Lucify").font(Font.title2.weight(.bold)).foregroundColor(.white)
                    Spacer()
                    Image(systemName: "note.text").font(.title).padding(.trailing, 10).foregroundColor(.white)
                }.frame(height: 30).padding(10)
                VStack() {
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Text("Your Progress").font(Font.largeTitle.weight(.bold)).padding(.top).padding(.leading)
                            Spacer()
                        }
                        HStack {
                            StatisticCardView(title: "Lucid Dreams", count: 20)
                            StatisticCardView(title: "Lucid Dreams", count: 20)
                        }
                        HStack {
                            Text("Start dreaming").font(Font.largeTitle.weight(.bold)).padding(.top).padding(.leading)
                            Spacer()
                        }
                        TechniqueCardView(type: .MILD, description: "Mnemonic Induced Lucid Dream", onClick: onTechniqueClicked)
                        TechniqueCardView(type: .SSILD, description: "Senses Initiated Lucid Dream", onClick: onTechniqueClicked)
                        TechniqueCardView(type: .FILD, description: "Finger Induced Lucid Dream", onClick: onTechniqueClicked)
                        TechniqueCardView(type: .RAUSIS, description: "Uses multiple chained Alarms to induce Lucid Dreams", onClick: onTechniqueClicked)
                        TechniqueCardView(type: .WILD, description: "Wake Induced Lucid Dream", onClick: onTechniqueClicked).padding(.bottom, 10)
                        Spacer()
                        HStack {
                            
                        }.background(Color("Primary"))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("Home Overlay")).cornerRadius(17)
                
            }
            HalfASheet(isPresented: $isPresented ) {
                VStack {
                    TechniqueSelectionView(selectedTechnique: $selectedTechnique, allAlarms: $allAlarms)
                    Button("Done") {
                        alarmManager.setAlarms(alarms: allAlarms)
                        alarmsActive = true
                    }.buttonStyle(.bordered).foregroundColor(Color("Primary"))
                }
            }.height(.proportional(0.5)).contentInsets(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0)).backgroundColor(UIColor.systemGroupedBackground)
        }.background(Color("Home Background"))
    }
    
    func onTechniqueClicked(type: Technique) -> Void {
        selectedTechnique = type
        isPresented = true
    }
}

struct AlarmEditView_Previews: PreviewProvider {
    static var previews: some View {
        TechniquesView().environmentObject(AlarmManager())
    }
}


