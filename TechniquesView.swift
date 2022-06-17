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
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "bed.double.circle.fill")
                        .font(.title)
                        .padding(.leading, 10)
                        .foregroundColor(.white)
                    Spacer()
                    Text("Lucify")
                        .font(Font.title2.weight(.bold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "note.text")
                        .font(.title)
                        .padding(.trailing, 10)
                        .foregroundColor(.white)
                }
                .frame(height: 30)
                .padding(10)
                VStack() {
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Text("Your Progress")
                                .font(Font.largeTitle.weight(.bold))
                                .padding(.top)
                                .padding(.leading)
                            Spacer()
                        }
                        HStack {
                            StatisticCardView(title: "Lucid Dreams", count: 20)
                            StatisticCardView(title: "Normal Dreams", count: 20)
                        }
                        HStack {
                            Text("Start dreaming")
                                .font(Font.largeTitle.weight(.bold))
                                .padding(.top)
                                .padding(.leading)
                            Spacer()
                        }
                        TechniqueCardView(type: .MILD, description: "Mnemonic Induced Lucid Dream", onClick: onTechniqueClicked)
                        TechniqueCardView(type: .SSILD, description: "Senses Initiated Lucid Dream", onClick: onTechniqueClicked)
                        TechniqueCardView(type: .FILD, description: "Finger Induced Lucid Dream", onClick: onTechniqueClicked)
                        TechniqueCardView(type: .RAUSIS, description: "Uses multiple chained Alarms to induce Lucid Dreams", onClick: onTechniqueClicked)
                        TechniqueCardView(type: .WILD, description: "Wake Induced Lucid Dream", onClick: onTechniqueClicked).padding(.bottom, 10)
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("Home Overlay")).cornerRadius(17)
            }
            TechniqueSheetView(isPresented: $isPresented, selectedTechnique: $selectedTechnique) {
                alarms in alarmManager.setAlarms(alarms: alarms)
                alarmsActive = true
            }
        }
        .background(Color("Home Background"))
        .sheet(isPresented: $alarmsActive) {
            AlarmView().environmentObject(alarmManager).onAppear {
                isPresented = false
            }
        }
    }
    
    func onTechniqueClicked(type: Technique) -> Void {
        selectedTechnique = type
        isPresented = true
    }
}

class AlarmEditView_Previews: PreviewProvider {
    static var previews: some View {
        TechniquesView().environmentObject(AlarmManager())
    }

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: TechniquesView())
    }
    #endif
}


