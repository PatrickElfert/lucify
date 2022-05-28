//
//  ContentView.swift
//  Shared
//
//  Created by Patrick Elfert on 16.05.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var alarmManager = AlarmManager()
    @State var selectedTab = "DreamDiary"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TechniquesView().tag("DreamDiary").tabItem {
                Label("Alarms", systemImage: "alarm")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
