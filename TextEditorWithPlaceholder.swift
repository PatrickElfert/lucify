//
//  TextEditorWithPlaceholder.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 07.06.22.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                VStack {
                    Text(text == "" ? "Write something..." : "")
                        .padding(.top, 10)
                        .padding(.leading, 6)
                        .opacity(0.3)
                    Spacer()
                }
            }

            VStack {
                TextEditor(text: $text)
                    .frame(minHeight: 150, maxHeight: 300)
                    .opacity(text.isEmpty ? 0.85 : 1)
                Spacer()
            }
        }
    }
}

struct TextEditorWithPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorWithPlaceholder(text: .constant(""))
    }
}
