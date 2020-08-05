//
// Created by Sergey Chelak
//

import Foundation

struct QuoteSymbol: Codable {
    var opens: [Decimal]
    var closures: [Decimal]
    var highs: [Decimal]
    var lows: [Decimal]
    var symbol: String
    var timestamps: [Int]
    var volumes: [Int]
}


extension QuoteSymbol {

    var count: Int {
        opens.count
    }

    var isValid: Bool {
        let count = opens.count
        guard count == closures.count else {
            return false
        }
        guard count == highs.count else {
            return false
        }
        guard count == lows.count else {
            return false
        }
        guard count == timestamps.count else {
            return false
        }
        guard count == volumes.count else {
            return false
        }
        return true
    }

}


extension QuoteSymbol {

    var performance: [Double] {
        StockMath.performance(opens)
    }

}
