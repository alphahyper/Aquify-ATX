//
//  MainPageView.swift
//  AquifyATX
//
//  Created by user259749 on 6/21/24.
//

import SwiftUI

struct MainPageView: View {
    var body: some View {
        let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
        ZStack{
            VStack {
                HStack{
                    RoundedRectangle(cornerRadius: 1.0)
                        .foregroundColor(skyBlue)
                        .frame(width: 100, height: 50)
                        .padding(.horizontal,20)
                    RoundedRectangle(cornerRadius: 1.0)
                        .foregroundColor(skyBlue)
                        .frame(width: 100, height: 90)
                    Image("calendar")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .padding(.leading, 15)
                }
                Text("AquifyATX")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.bottom,25)
                    .padding(.top,25)
                Image("logo")
                    .resizable()
                    .frame(width:300,height:155)
                    .padding(.bottom,55)
                RoundedRectangle(cornerRadius: 1.0)
                    .foregroundColor(skyBlue)
                    .frame(width: 325, height: 65)
                    .padding(.bottom,30)
                RoundedRectangle(cornerRadius: 1.0)
                    .foregroundColor(skyBlue)
                    .frame(width: 325, height: 65)
                    .padding(.bottom,30)
                RoundedRectangle(cornerRadius: 1.0)
                    .foregroundColor(skyBlue)
                    .frame(width: 325, height: 65)
                    .padding(.bottom,65)
            }
        }
    }
}

#Preview {
    MainPageView()
}
