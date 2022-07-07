//
//  DreamDiarySheetView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 07.06.22.
//

import SwiftUI

struct DreamDiarySheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var diaryEntry: DiaryEntryModel
    var onSave: (DiaryEntryModel) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Record dream")
                .font(Font.largeTitle.weight(.bold))
                .padding(.top)
                .padding(.leading)
            Form {
                Section {
                    TextField("Title", text: $diaryEntry.title)
                }
                Section {
                    TextEditorWithPlaceholder(text: $diaryEntry.description)
                }

                Section {
                    Toggle("Lucid", isOn: $diaryEntry.isLucid).tint(Color("Primary"))
                }
            }
            Button(action: {
                onSave(diaryEntry)
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
        DreamDiarySheetView(diaryEntry: DiaryEntryModel(date: Date.now, title: "test", description: "testdc", isLucid: true), onSave: { _ in })
    }
}
