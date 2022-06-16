//
//  TechniqueCard.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 13.06.22.
//

import SwiftUI

struct TechniqueCardView: View {
    var type: Technique
    var description: String
    var onClick: (Technique) -> Void
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(type.rawValue).font(Font.title3.weight(.bold))
                Text(description).font(Font.body)
            }.padding(10)
            Spacer()
        }.frame(width: 327, height: 90).background(Color("Primary")).cornerRadius(17).padding(.leading, 2).onTapGesture {
            onClick(type)
        }
    }
}

struct TechniqueCard_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueCardView(type: Technique.MILD, description: "Mnemonic Induced Lucid Dream" ) {
            technique in
        }
    }
}
