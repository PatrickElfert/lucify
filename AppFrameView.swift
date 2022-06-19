//
//  AlarmView.swift
//  Lucify
//
//  Created by Patrick Elfert on 21.05.22.
//

import HalfASheet
import SwiftUI

struct AppFrameView: View {
    @ObservedObject var notificationManager: NotificationManager = .init()
    @State private var selectedView = "Home"

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    MenuItemView(selected: $selectedView, name: "Home", icon: "bed.double.circle.fill")
                    Spacer()
                    Text("Lucify")
                        .font(Font.title2.weight(.bold))
                        .foregroundColor(.white)
                    Spacer()
                    MenuItemView(selected: $selectedView, name: "Dreams", icon: "note.text")
                }
                .frame(height: 30)
                .padding(10)
                if selectedView == "Home" {
                    HomeView()
                } else if selectedView == "Dreams" {
                    DreamDiaryView()
                }
            }
        }
        .background(Color("Home Background"))
    }
}

class AppFrameView_Previews: PreviewProvider {
    static var previews: some View {
        AppFrameView()
    }
}
