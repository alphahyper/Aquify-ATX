//
//  CalendarPageView.swift
//  AquifyATX
//
//  Created by user259749 on 6/23/24.
//

import SwiftUI

struct CalendarPageView: View {
    @EnvironmentObject var dateHolder: DateHolder
    var body: some View {
        VStack(spacing: 1){
            DateScrollerView()
                .environmentObject(dateHolder)
                //.padding
            dayOfWeekStack
        }
    }
    
    var dayOfWeekStack: some View
    {
        HStack(spacing: 1){
            Text("Sun").dayOfWeek()
            Text("Mon").dayOfWeek()
            Text("Tue").dayOfWeek()
            Text("Wed").dayOfWeek()
            Text("Thu").dayOfWeek()
            Text("Fri").dayOfWeek()
            Text("Sat").dayOfWeek()
        }
    }
    
    var calendarGrid: some View
    {
        VStack(spacing: 1){
            let daysInMonth = CalendarHelper().daysInMonth(_date: dateHolder.date)
            let firstDayOfMonth = CalendarHelper().firstOfMonth(_date: dateHolder.date)
            let startingSpaces = CalendarHelper().weekDay(_date: firstDayOfMonth)
            let prevMonth = CalendarHelper().minusMonth(_date: dateHolder.date)
            let daysInPrevMonth = CalendarHelper().daysInMonth(_date: prevMonth)
            ForEach(0..<6)
            {
            row in
                HStack(spacing: 1){
                    ForEach(1..<8)
                    {
                        column in
                        let count = column + (row * 7)
                        CalendarCell(count: count, startingSpaces: startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth)
                            .environmentObject(dateHolder)
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    CalendarPageView()
}

extension Text{
    func dayOfWeek() -> some View
    {
        self.frame(maxWidth: .infinity)
            .padding(.top, 1)
            .lineLimit(1)
    }
}

/*extension ForEach where Data == Range<Int>, ID == Int, Content : View {
    public init(_ range: ClosedRange<Int>, @ViewBuilder content: @escaping (Int) -> Content) {
        self.init(range.lowerBound..<(range.upperBound+1), id: \.self, content: content)
    }
}*/
