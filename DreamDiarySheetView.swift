//
//  DreamDiarySheetView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 07.06.22.
//

import SwiftUI

struct DreamDiarySheetView: View {
    @Environment(\.dismiss) var dismiss
    var forDate: Date
    @State var newDiaryEntry = DiaryEntryModel()
    var onSave: (DiaryEntryModel) -> Void

    init(diaryEntry: DiaryEntryModel, onSave: @escaping (DiaryEntryModel) -> Void) {
        forDate = diaryEntry.date
        self.onSave = onSave
        newDiaryEntry = diaryEntry
    }

    init(forDate: Date, onSave: @escaping (DiaryEntryModel) -> Void) {
        self.forDate = forDate
        self.onSave = onSave
    }

    var body: some View {
        Form {
            TextField("Title", text: $newDiaryEntry.title)
            TextEditorWithPlaceholder(text: $newDiaryEntry.description)
            Toggle("Lucid", isOn: $newDiaryEntry.isLucid)
            Button("Save") {
                newDiaryEntry.date = forDate
                onSave(newDiaryEntry)
                dismiss()
            }.foregroundColor(Color("Primary"))
        }
    }
}

struct DreamDiarySheetView_Previews: PreviewProvider {
    static var previews: some View {
        DreamDiarySheetView(forDate: Date.now, onSave: { _ in }).environment(\.colorScheme, .dark)
    }
}
