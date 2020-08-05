//
// Created by Sergey Chelak
//

import SwiftUI

struct BrokenLineView: View {

    class FrameDataHolder {
        var xStep: Double = 0
        var values: [Double] = []
    }

    @State var labelLocation = CGPoint.zero
    @State var labelText = ""
    var frameDataHolder = FrameDataHolder()
    var data: [Double]
    var colorModel: ColorModel
    var globalMax: Double?
    var globalMin: Double?


    var body: some View {
        ZStack {
            GeometryReader { reader in
                Path { path in
                    guard self.data.count > 1,
                          let min = self.globalMin ?? self.data.min(),
                          let max = self.globalMax ?? self.data.max() else {
                        return
                    }
                    let rate = Double(reader.size.height) / (max - min)
                    let values = self.data.map {
                        ($0 - min) * rate
                    }
                    let xStep = Double(reader.size.width) / Double(self.data.count)
                    self.frameDataHolder.xStep = xStep
                    self.frameDataHolder.values = values
                    path.move(to: CGPoint(x: 0, y: values[0]))
                    for i in 0..<values.count {
                        path.addLine(to: CGPoint(x: Double(i + 1) * xStep, y: values[i]))
                    }
                }
                .stroke(self.colorModel.color, style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }.gesture(
                    DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let xStep = self.frameDataHolder.xStep
                                let x = Int(Double(value.location.x) / xStep)
                                guard (0..<self.data.count).contains(x) else {
                                    return
                                }
                                self.labelLocation = CGPoint(x: Double(x + 1) * xStep, y: self.frameDataHolder.values[x])
                                self.labelText = String(format: "%5.3f", self.data[x])
                            }
                            .onEnded { _ in
                                self.labelLocation = CGPoint.zero
                                self.labelText = ""
                            }
            )

            if !labelText.isEmpty {
                Text(labelText)
                    .foregroundColor(self.colorModel.inverted.color)
                    .background(self.colorModel.color)
                    .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                    .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(self.colorModel.color, lineWidth: 4)
                    )
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .position(labelLocation)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
    }

}



struct BrokenLine_Previews: PreviewProvider {
    static var previews: some View {
        let data: [Double] = [0.0, 20, 10, 40, 30, 60, -10]
        return BrokenLineView(data: data, colorModel: ColorModel.random())
    }
}
