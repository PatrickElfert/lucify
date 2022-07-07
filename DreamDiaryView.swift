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
    @State var selectedEntry: DiaryEntryModel?
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
                            DiaryEntryCardView(title: entry.title, content: entry.description, isLucid: entry.isLucid).padding(20).onTapGesture {
                                selectedEntry = entry
                                print(selectedEntry!)
                                isDreamDiarySheetVisible = true
                            }
                        }
                    }
                }
            }.background(Color("Home Overlay"))
        }
        .sheet(isPresented: $isDreamDiarySheetVisible) {
            if selectedEntry != nil {
                DreamDiarySheetView(diaryEntry: selectedEntry!) { entry in
                    dreamDiaryManager.addEntries(date: selectedDay, newEntries: [entry])
                }
            } else {
                DreamDiarySheetView(diaryEntry: DiaryEntryModel(date: selectedDay, title: "", description: "", isLucid: false)) { entry in
                    dreamDiaryManager.addEntries(date: selectedDay, newEntries: [entry])
                }
            }
        }
        .floatingActionButton(color: Color("Primary"), image: Image(systemName: "plus").foregroundColor(.white)) {
            selectedEntry = nil
            isDreamDiarySheetVisible = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Home Overlay"))
        .cornerRadius(radius: 17, corners: [.topLeft, .topRight])
        .onAppear {
            dreamDiaryManager.loadEntries(date: selectedDay)
        }
    }

    struct DreamDiaryView_Previews: PreviewProvider {
        static var previews: some View {
            DreamDiaryView(dreamDiaryManager: DreamDiaryManager())
        }
    }
}
