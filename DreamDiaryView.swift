//
//  DreamDiaryView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 11.06.22.
//

import SwiftUI

struct DreamDiaryView: View {
    init(dreamDiaryManager: DreamDiaryManager = DreamDiaryManager()) {
        self.dreamDiaryManager = dreamDiaryManager
    }

    var dreamDiaryManager: DreamDiaryManager

    var body: some View {
        VStack {
            if dreamDiaryManager.entries.count == 0 {
                VStack(alignment: .leading) {
                    Text("You have not recorded any dreams, you can record dreams after you turn off an alarm.").font(.body).opacity(0.5).padding().frame(maxHeight: .infinity)
                }.navigationTitle("Dreams")
            } else {
                VStack {
                    DatePickerBarView().padding(.top)
                    ScrollView {
                        ForEach(dreamDiaryManager.entries) {
                            entry in
                            DiaryEntryCardView(title: entry.title, content: entry.description, isLucid: entry.isLucid).padding(20)
                        }
                    }
                }.background(Color("Home Overlay"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Home Overlay")).cornerRadius(17)
    }

    struct DreamDiaryView_Previews: PreviewProvider {
        static var previews: some View {
            DreamDiaryView(dreamDiaryManager: DreamDiaryManager(entries: [DiaryEntryDTO(from: DiaryEntryModel(date: "2022-09-04T17:10Z".toDate(.isoDateTime)!, title: "TestTitle", description: "TestDescription", isLucid: true))]))
        }
    }
}
