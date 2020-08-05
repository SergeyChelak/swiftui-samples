//
// Created by Sergey Chelak
//

import SwiftUI

struct PerformanceChartView: View {

    @ObservedObject var model: PerformanceViewModel
    var title: String

    var body: some View {
        VStack {
            Text(title)
            ZStack {
                GridView(globalMax: self.model.max, globalMin: self.model.min, count: model.data.first?.count ?? 0)
                ForEach(model.performances) { item in
                    BrokenLineView(data: item.performance,
                            colorModel: item.colorModel,
                            globalMax: self.model.max, globalMin: self.model.min)
                }
            }.padding()
            HStack {
                ForEach(model.performances) { item in
                    Text(item.id)
                        .foregroundColor(item.colorModel.color)
                }
            }
        }.alert(isPresented: model.isPresentingErrorAlert, content: {
            Alert(title: Text("Error"), message: Text("Oops, something went wrong"), dismissButton: .default(Text("Dismiss")))
        })
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceChartView(model: PerformanceViewModel {
            []
        }, title: "Line Chart")
    }
}
