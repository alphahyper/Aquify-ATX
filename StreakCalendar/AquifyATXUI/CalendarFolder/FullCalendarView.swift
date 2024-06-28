//
//  FullCalendarView.swift
//  AquifyATX
//
//  Created by user259749 on 6/26/24.
//

import SwiftUI

struct FullCalendarView: View {
    var body: some View {
        let dateHolder = DateHolder()
        CalendarPageView()
            .environmentObject(dateHolder)
    }
}

#Preview {
    FullCalendarView()
}
