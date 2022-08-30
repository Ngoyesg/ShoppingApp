//
//  FakeSearchItemUseCase.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeSearchItemUseCase: SearchItemUseCaseProtocol {
    
    var successCase = false
    var searchWasCalled = false
    
    let mockedProductToDisplay = [ProductsToDisplay(id: "any", title: "any", prices: 1.0, currency: "COP", thumbnail: Data(), quantityOfInstallments: 1, installments: 1.0, availableQuantity: 1, soldQuantity: 1)]
    
    func executeSearch(with endpointInfo: EndpointInfo, onSuccess: @escaping ([ProductsToDisplay]) -> (Void), onError: @escaping (WebServiceError) -> (Void)) {
        searchWasCalled = true
        
        if successCase {
            onSuccess(mockedProductToDisplay)
        } else {
            onError(.searchFailed)
        }
    }   
}
