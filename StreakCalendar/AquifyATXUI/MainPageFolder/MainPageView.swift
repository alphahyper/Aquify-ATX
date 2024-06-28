//
//  MainPageView.swift
//  AquifyATX
//
//  Created by user259749 on 6/21/24.
//

import SwiftUI



struct MainPageView: View {
    @State var progressValue: Float = 0.0
    var body: some View {
        let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
        NavigationView {
            ZStack{
                VStack {
                    HStack{
                        ProgressBar(progress: self.$progressValue , color: Color.red)
                            .frame(width: 75, height: 75)
                            .padding(20.0).onAppear() {
                                self.progressValue = 0.80
                            }
                        Button {
                            placeholder()
                            
                        } label: {
                            Image("trophy")
                                .resizable()
                                .frame(width: 75, height: 75)
                        }
                        Button {
                            placeholder()
                            
                        } label: {
                            Image("calendar")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .padding(.leading, 15)
                        }
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
                    Button {
                        placeholder()
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 1.0)
                            .foregroundColor(skyBlue)
                            .frame(width: 325, height: 65)
                            .padding(.bottom,30)
                    }
                    Button {
                        placeholder()
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 1.0)
                            .foregroundColor(skyBlue)
                            .frame(width: 325, height: 65)
                            .padding(.bottom,30)
                    }
                    Button {
                        placeholder()
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 1.0)
                            .foregroundColor(skyBlue)
                            .frame(width: 325, height: 65)
                            .padding(.bottom,65)
                    }
                }
            }
            //Overlay of Text
            VStack {
                Text("Find Nearest Water Station")
                    .fontWeight(.semibold)
                    //.padding
                Text("Enter Ounces of Water Drank")
                    .fontWeight(.semibold)
                     //.padding
                Text("Change User Info")
                    .fontWeight(.semibold)
                     //.padding
            }
        }
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    var color: Color = Color.green
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress,1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                //.withAnimation(.easeInOut(duration: 2.0))
        }    }
}



private func placeholder(){
    print("placeholder")
}

#Preview {
    MainPageView()
}
