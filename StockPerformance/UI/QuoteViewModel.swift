//
// Created by Sergey Chelak
//

import Foundation
import Combine
import SwiftUI

class QuoteViewModel: ObservableObject {

    typealias FetchRequestHandler = () throws -> [QuoteSymbol]

    @Published private(set) var error: Error? = nil
    @Published var data: [QuoteSymbol] = [QuoteSymbol]()

    private let handler: FetchRequestHandler

    init(_ handler: @escaping FetchRequestHandler) {
        self.handler = handler
        fetchData()
    }

    func fetchData() {
        DispatchQueue.global(qos: .background).async { [unowned self] in
            do {
                let receviedData = try self.handler()
                DispatchQueue.main.async { [unowned self] in
                    self.data = receviedData
                }
            } catch {
                self.error = error
            }
        }
    }
    
    var isPresentingErrorAlert: Binding<Bool> {
        Binding<Bool>(get: {
            self.error != nil
        }, set: { newValue in
            guard !newValue else { return }
            self.error = nil
        })
    }

}
