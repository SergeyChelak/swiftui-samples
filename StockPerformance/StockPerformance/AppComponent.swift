//
//  Created by Sergey Chelak
//

import Foundation
import SwiftUI

struct AppComponent {
    
    private let weekData: PerformanceViewModel
    private let monthData: PerformanceViewModel
    
    init(_ api: StocksAPI) {
        weekData = PerformanceViewModel {
            try api.getWeekQuotes()
        }
        monthData = PerformanceViewModel {
            try api.getMonthQuotes()
        }
    }
    
    var initialView: some View {
        RootTabView(weekDataModel: weekData, monthDataModel: monthData)
    }
    
}
