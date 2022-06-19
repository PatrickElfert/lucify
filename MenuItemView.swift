//
//  MenuItemView.swift
//  Lucify (iOS)
//
//  Created by Patrick Elfert on 19.06.22.
//

import SwiftUI

struct MenuItemView: View {
    @Binding var selected: String
    var name: String
    var icon: String

    var body: some View {
        Image(systemName: icon)
            .font(.title)
            .padding(.leading, 10)
            .foregroundColor(.white).onTapGesture {
                selected = name
            }
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(selected: .constant("Home"), name: "Home", icon: "bed.double.circle.fill")
    }
}
