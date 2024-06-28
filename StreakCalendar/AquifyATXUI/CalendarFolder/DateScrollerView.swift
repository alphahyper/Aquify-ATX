//
//  DateScrollerView.swift
//  AquifyATX
//
//  Created by user259749 on 6/26/24.
//

import SwiftUI

struct DateScrollerView: View {
    @EnvironmentObject var dateHolder: DateHolder
    var body: some View {
        HStack {
            Spacer()
            Button(action: previousMonth){
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .font(Font.title.weight(.bold))
            }
            //Text(
            Button(action: nextMonth){
                Image(systemName: "arrow.right")
                    .imageScale(.large)
                    .font(Font.title.weight(.bold))
            }
            Spacer()
        }
    }
    func previousMonth(){
        dateHolder.date = CalendarHelper().minusMonth(_date: dateHolder.date)
    }
    
    func nextMonth(){
        dateHolder.date = CalendarHelper().plusMonth(_date: dateHolder.date)
    }
}



#Preview {
    DateScrollerView()
}
