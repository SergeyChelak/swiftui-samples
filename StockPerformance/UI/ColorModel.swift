//
//  ColorModel.swift
//  StockPerformance
//
//  Created by Sergey Chelak on 05.08.2020.
//  Copyright © 2020 Sergey Chelak. All rights reserved.
//

import Foundation

struct ColorModel {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double
    
    static func random() -> ColorModel {
        ColorModel(
                red: Double(arc4random_uniform(255)) / 255.0,
                green: Double(arc4random_uniform(255)) / 255.0,
                blue: Double(arc4random_uniform(255)) / 255.0,
                alpha: 1.0)
    }
    
    var inverted: ColorModel {
        ColorModel(
        red: 1 - red,
        green: 1 - green,
        blue: 1 - blue,
        alpha: alpha)
    }
}


