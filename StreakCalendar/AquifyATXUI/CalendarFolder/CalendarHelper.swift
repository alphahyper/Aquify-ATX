//
//  CalendarHelper.swift
//  AquifyATX
//
//  Created by user259749 on 6/26/24.
//

import Foundation

class CalendarHelper
{
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func monthYearString(_date: Date) -> String
    {
        dateFormatter.dateFormat = "LLL yyyy"
        return dateFormatter.string(from: _date)
    }
    
    func plusMonth(_date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: 1, to: _date)!
    }
    
    func minusMonth(_date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: -1, to: _date)!
    }
    
    func daysInMonth(_date: Date) -> Int
    {
        let range = calendar.range(of: .day, in: .month, for: _date)!
        return range.count
    }
    
    func dayOfMonth(_date: Date) -> Int
    {
        let components = calendar.dateComponents([.day], from: _date)
        return components.day!
    }
    
    func firstOfMonth(_date: Date) -> Date{
        let components = calendar.dateComponents([.year, .month], from: _date)
        return calendar.date(from: components)!
    }
    
    func weekDay(_date: Date) -> Int{
        let components = calendar.dateComponents([.weekday], from: _date)
        return components.weekday!
    }
}
