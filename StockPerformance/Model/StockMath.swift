//
// Created by Sergey Chelak
//

import Foundation

struct StockMath {

    public static func performance(_ price: [Decimal]) -> [Double] {
        var result: [Double] = [0]
        guard let first = price.first,
              price.count > 1 else {
            return result
        }
        for i in 1..<price.count {
            let value = Decimal(1) - price[i] / first
            result.append(100 * value.doubleValue)
        }
        return result
    }

}


extension Decimal {

    var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }

}
