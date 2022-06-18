//
//  DreamDiarySheetView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 07.06.22.
//

import SwiftUI

struct DreamDiarySheetView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var newDiaryEntry = DiaryEntryModel()
    var dreamDiaryManager = DreamDiaryManager()

    init(forAlarmDate: Date) {
        newDiaryEntry.date = forAlarmDate
    }

    var body: some View {
        Form {
            TextField("Title", text: $newDiaryEntry.title)
            TextEditorWithPlaceholder(text: $newDiaryEntry.description)
            Toggle("Lucid", isOn: $newDiaryEntry.isLucid)
            Button("Save") {
                dreamDiaryManager.entries.append(DiaryEntryDTO(from: newDiaryEntry))
                dismiss()
            }
        }
    }
}

struct DreamDiarySheetView_Previews: PreviewProvider {
    static var previews: some View {
        DreamDiarySheetView(forAlarmDate: Date.now)
    }
}
