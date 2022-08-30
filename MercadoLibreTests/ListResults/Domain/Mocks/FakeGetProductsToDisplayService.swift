//
//  FakeGetProductsToDisplayService.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeGetProductsToDisplayService: GetProductsToDisplayServiceProtocol {
    
    var successCase = false
    let mockedResponse = [ProductsToDisplay(id: "any", title: "any", prices: 1.0, currency: "COP", thumbnail: Data(), quantityOfInstallments: 1, installments: 1.0, availableQuantity: 1, soldQuantity: 1)]
    
    func executeSearch(with productsListResponse: ListProductsAPIResponse, onSuccess: @escaping ([ProductsToDisplay]) -> (Void), onError: @escaping (WebServiceError) -> (Void)) {
        if successCase {
            onSuccess(mockedResponse)
        } else {
            onError(.searchFailed)
        }
    }
    
    
}
