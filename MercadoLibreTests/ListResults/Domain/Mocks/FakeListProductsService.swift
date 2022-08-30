//
//  FakeListProductsService.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeListProductsService: ListProductsServiceProtocol {
    
    var successCase = false
    let mockedResponse = ListProductsAPIResponse(results: [ItemResults(id: "any", title: "any", price: 1.0, currency: "COP", thumbnail: "anythumbailURL", availableQuantity: 1, soldQuantity: 1, installments: InstallmentInfo(amount: 1.0, quantity: 1))])
    
    func getProductsInformation(for itemInMarket: EndpointInfo, onSuccess: @escaping (ListProductsAPIResponse) -> Void, onError: @escaping (WebServiceError) -> Void) {
        if successCase {
            onSuccess(mockedResponse)
        } else {
            onError(.searchFailed)
        }
    }
    
}
