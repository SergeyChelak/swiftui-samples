//
// Created by Sergey Chelak
//

import Foundation

struct QuoteSymbolsResponse: Codable {

    struct Content: Codable {
        var quoteSymbols: [QuoteSymbol]
    }

    var status: String
    var content: Content

    var isSuccessful: Bool {
        status == "ok"
    }
}

extension QuoteSymbolsResponse {

    static func parse(_ data: Data) throws -> [QuoteSymbol] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(QuoteSymbolsResponse.self, from: data)
        guard response.isSuccessful else {
            throw APIError.badResponse
        }
        try response.content.quoteSymbols.forEach {
            guard $0.isValid else {
                throw APIError.invalidResponseData
            }
        }
        return response.content.quoteSymbols
    }

}