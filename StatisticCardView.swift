//
//  StatisticCardView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 13.06.22.
//

import SwiftUI

struct StatisticCardView: View {
    var title: String
    var count: Int
    
    var body: some View {
        VStack {
            Text("\(count)").font(.largeTitle).fontWeight(.heavy)
            Text(title).font(.caption)
        }.frame(width: 120, height: 90).background(Color("Primary")).cornerRadius(17).padding(5)
    }
}

struct StatisticCardView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticCardView(title: "Normal Dreams", count: 20)
    }
}
