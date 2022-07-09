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
    @State var showingAlert = false
    var onSave: (DiaryEntryModel) -> Void
    var onDelete: ((DiaryEntryModel) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .firstTextBaseline) {
                Text("Record dream")
                    .font(Font.largeTitle.weight(.bold))
                if onDelete != nil {
                    Image(systemName: "trash.circle.fill")
                        .font(.title)
                        .padding(.leading, 10)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .red)
                        .onTapGesture {
                            showingAlert = true
                        }
                }
            }.padding([.top, .leading])
                .alert("Do you really want to delete this Dream?", isPresented: $showingAlert) {
                    Button("Cancel", role: .cancel) {}
                    Button("Ok", role: .destructive) {
                        onDelete!(diaryEntry)
                        dismiss()
                    }
                }
            Form {
                Section {
                    TextField("Title", text: $diaryEntry.title)
                }
                Section {
                    TextEditorWithPlaceholder(text: $diaryEntry.description)
                }

                Section {
                    Toggle("Lucid", isOn: $diaryEntry.isLucid).tint(Primary)
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
            .background(Primary)
            .cornerRadius(5)
            .foregroundColor(.primary).padding()
        }
    }
}

struct DreamDiarySheetView_Previews: PreviewProvider {
    static var previews: some View {
        DreamDiarySheetView(diaryEntry: DiaryEntryModel(date: Date.now, title: "test", description: "testdc", isLucid: true), onSave: { _ in }, onDelete: { _ in })
    }
}
