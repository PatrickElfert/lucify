//
//  DreamDiaryView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 11.06.22.
//

import SwiftUI
import SwiftUI_FAB

struct DreamDiaryView: View {
    init(dreamDiaryManager: DreamDiaryManager = DreamDiaryManager()) {
        self.dreamDiaryManager = dreamDiaryManager
    }

    @State var selectedDay = Date.now
    @State var isDreamDiarySheetVisible = false
    @ObservedObject var dreamDiaryManager: DreamDiaryManager

    var body: some View {
        VStack {
            VStack {
                DatePickerBarView(selectedDay: $selectedDay).padding(.top).onChange(of: selectedDay) { day in dreamDiaryManager.loadEntries(date: day) }
                if dreamDiaryManager.entries.count == 0 {
                    Text("You have not recorded any dreams for this day").font(.body).opacity(0.5).padding().frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        ForEach(dreamDiaryManager.entries) {
                            entry in
                            DiaryEntryCardView(title: entry.title, content: entry.description, isLucid: entry.isLucid).onTapGesture {
                                isDreamDiarySheetVisible = true
                            }.padding(20)
                        }
                    }
                }
            }.background(Color("Home Overlay"))
        }.floatingActionButton(color: Color("Primary"), image: Image(systemName: "plus").foregroundColor(.white)) {
            isDreamDiarySheetVisible = true
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Home Overlay"))
            .cornerRadius(radius: 17, corners: [.topLeft, .topRight])
            .sheet(isPresented: $isDreamDiarySheetVisible) {
                DreamDiarySheetView(forDate: selectedDay) { entry in
                    dreamDiaryManager.addEntries(date: selectedDay, newEntries: [entry])
                }
            }.onAppear {
                dreamDiaryManager.loadEntries(date: selectedDay)
            }
    }

    struct DreamDiaryView_Previews: PreviewProvider {
        static var previews: some View {
            DreamDiaryView(dreamDiaryManager: DreamDiaryManager())
        }
    }
}
