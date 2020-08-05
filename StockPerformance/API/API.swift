//
// Created by Sergey Chelak
//

import Foundation

protocol StocksAPI {
    func getMonthQuotes() throws -> [QuoteSymbol]
    func getWeekQuotes() throws -> [QuoteSymbol]
}

enum APIError: Error {
    case unexpected
    case badResponse
    case invalidResponseData
    case badRequest
}
