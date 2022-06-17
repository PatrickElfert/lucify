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
        VStack {
            TechniquesView()
        }
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: ContentView())
    }
    #endif
}
