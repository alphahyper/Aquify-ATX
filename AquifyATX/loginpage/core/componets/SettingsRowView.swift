//
//  SettingsRowView.swift
//  loginpage
//
//  Created by Bill Mar on 6/19/24.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName:String
    let title: String
    let tintColor: Color

    var body: some View {
        HStack(spacing:12){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title:"Version", tintColor: Color(.systemGray))
}
