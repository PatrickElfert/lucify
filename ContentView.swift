//
//  ContentView.swift
//  Shared
//
//  Created by Patrick Elfert on 16.05.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var alarmManager = AlarmManager()
    @State var selectedTab = "Alarms"
    
    var body: some View {
        TechniquesView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
