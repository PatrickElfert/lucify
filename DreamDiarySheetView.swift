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
        VStack(alignment: .leading, spacing: 0) {
            Text("Record dream")
                .font(Font.largeTitle.weight(.bold))
                .padding(.top)
                .padding(.leading)
            Form {
                Section {
                    TextField("Title", text: $newDiaryEntry.title)
                }
                Section {
                    TextEditorWithPlaceholder(text: $newDiaryEntry.description)
                }

                Section {
                    Toggle("Lucid", isOn: $newDiaryEntry.isLucid).tint(Color("Primary"))
                }
            }
            Button(action: {
                newDiaryEntry.date = forDate
                onSave(newDiaryEntry)
                dismiss()
            }) {
                HStack(alignment: .firstTextBaseline) {
                    Text("Save")
                    Image(systemName: "cloud.moon.fill")
                }.frame(maxWidth: .infinity, maxHeight: 50)
            }
            .background(Color("Primary"))
            .cornerRadius(5)
            .foregroundColor(.primary).padding()
        }
    }
}

struct DreamDiarySheetView_Previews: PreviewProvider {
    static var previews: some View {
        DreamDiarySheetView(forDate: Date.now, onSave: { _ in })
    }
}
