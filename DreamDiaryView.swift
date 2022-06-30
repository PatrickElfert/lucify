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
    @State var isDreamDairySheetVisible = false
    @State var entries: [DiaryEntryDTO] = []
    var dreamDiaryManager: DreamDiaryManager

    var body: some View {
        VStack {
            VStack {
                DatePickerBarView(selectedDay: $selectedDay).padding(.top)
                if dreamDiaryManager.getFilteredEntries(date: selectedDay).count == 0 {
                    Text("You have not recorded any dreams for this day").font(.body).opacity(0.5).padding().frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        ForEach(dreamDiaryManager.getFilteredEntries(date: selectedDay)) {
                            entry in
                            DiaryEntryCardView(title: entry.title, content: entry.description, isLucid: entry.isLucid).padding(20)
                        }
                    }
                }
            }.background(Color("Home Overlay"))
        }.floatingActionButton(color: Color("Primary"), image: Image(systemName: "plus").foregroundColor(.white)) {
            isDreamDairySheetVisible = true
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Home Overlay"))
            .cornerRadius(17)
            .sheet(isPresented: $isDreamDairySheetVisible, onDismiss: { entries = dreamDiaryManager.entries }) {
                DreamDiarySheetView(forAlarmDate: selectedDay)
            }.onAppear {
                entries = dreamDiaryManager.entries
            }
    }

    struct DreamDiaryView_Previews: PreviewProvider {
        static var previews: some View {
            DreamDiaryView(dreamDiaryManager: DreamDiaryManager(entries: [DiaryEntryDTO(from: DiaryEntryModel(date: Date.now.addingTimeInterval(24.hours), title: "TestTitle2", description: "TestDescription2", isLucid: true)), DiaryEntryDTO(from: DiaryEntryModel(date: Date.now, title: "TestTitle", description: "TestDescription", isLucid: true))]))
        }
    }
}
