//
//  DiaryEntryCardView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 25.06.22.
//

import SwiftUI

struct DiaryEntryCardView: View {
    var title: String
    var content: String
    var isLucid: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(title).font(Font.title3.weight(.bold)).lineLimit(2)
                    Spacer()
                    if isLucid {
                        Text("Lucid").font(Font.headline).padding(.horizontal, 10).background(PrimaryLight).cornerRadius(10).foregroundColor(.black)
                    }
                }
                Text(content).font(Font.body).opacity(0.8).padding(.leading, 3).lineLimit(5)
            }.padding()
            Spacer()
        }.frame(maxWidth: 327).background(Primary).cornerRadius(17).padding(.leading, 2)
    }
}

struct DiaryEntryCardView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryEntryCardView(title: "Some Dream", content: "This is the content of the dream, normally the dream has more content and i am testing if 6 lines is the right amount of lines to display a preview here so it seems 5 is way more", isLucid: true)
    }
}
