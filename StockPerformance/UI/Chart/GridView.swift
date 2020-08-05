//
// Created by Sergey Chelak
//

import SwiftUI

struct GridView: View {

    var globalMax: Double?
    var globalMin: Double?

    var count: Int

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    guard self.count > 1 else {
                        return
                    }
                    let xStep = geometry.size.width / CGFloat(self.count)
                    for i in 0...self.count {
                        path.move(to: CGPoint(x: CGFloat(i) * xStep, y: 0.0))
                        path.addLine(to: CGPoint(x: CGFloat(i) * xStep, y: geometry.size.height))
                    }
                    let yLines: Int = 20
                    let yStep = geometry.size.height / CGFloat(yLines - 1)
                    for i in 0..<yLines {
                        path.move(to: CGPoint(x: 0.0, y: CGFloat(i) * yStep))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: CGFloat(i) * yStep))
                    }
                }
                        .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [2, 2], dashPhase: 1))
                        .foregroundColor(Color.gray)
            }
            Path { path in
                guard let min = self.globalMin, let max = self.globalMax else {
                    return
                }
                let rate = Double(geometry.size.height) / (max - min)
                let zero = CGFloat(-min * rate)
                path.move(to: CGPoint(x: 0.0, y: zero))
                path.addLine(to: CGPoint(x: geometry.size.width, y: zero))
            }
                    .stroke(lineWidth: 1)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .foregroundColor(Color.red)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(count: 21)
    }
}
