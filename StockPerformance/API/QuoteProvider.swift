//
// Created by Sergey Chelak
//

import Foundation

class QuoteProvider: StocksAPI {

    func getMonthQuotes() throws -> [QuoteSymbol] {
        try provide("responseQuotesMonth")
    }

    func getWeekQuotes() throws -> [QuoteSymbol] {
        try provide("responseQuotesWeek")
    }

    private func provide(_ name: String) throws -> [QuoteSymbol] {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            throw APIError.badRequest
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try QuoteSymbolsResponse.parse(data)
    }

}
