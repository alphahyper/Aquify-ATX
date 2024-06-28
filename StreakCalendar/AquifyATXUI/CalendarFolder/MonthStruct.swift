//
//  MonthStruct.swift
//  AquifyATX
//
//  Created by user259749 on 6/26/24.
//

import Foundation

struct MonthStruct
{
    var monthType: MonthType
    var dayInt : Int
    func day() -> String
    {
        return String(dayInt)
    }
}

enum MonthType
{
    case Previous
    case Current
    case Next
}
