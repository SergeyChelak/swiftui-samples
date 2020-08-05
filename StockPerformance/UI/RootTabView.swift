//
// Created by Sergey Chelak
//

import SwiftUI

struct RootTabView: View {
    var weekDataModel: PerformanceViewModel
    var monthDataModel: PerformanceViewModel

    var body: some View {
        TabView {
            PerformanceChartView(model: weekDataModel, title: "Week Stocks Performance")
                    .tabItem {
                        Text("Week")
                    }
            PerformanceChartView(model: monthDataModel, title: "Month Stocks Performance")
                    .tabItem {
                        Text("Month")
                    }
        }
    }
}

struct RootTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        let model = PerformanceViewModel {
            return []
        }
        return RootTabView(weekDataModel: model, monthDataModel: model)
    }
}
