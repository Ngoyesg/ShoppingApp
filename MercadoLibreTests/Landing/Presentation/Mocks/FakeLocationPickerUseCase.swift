//
//  FakeLocationPickerUseCase.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeLocationPickerUseCase: LocationPickerUseCaseProtocol {
    
    var successCase = false
    
    let mockResponse = [SitesAPIResponse(name: "AnyCountry", id: "AnyId")]
    
    func execute(onSuccess: @escaping ([SitesAPIResponse]) -> (Void), onError: @escaping (WebServiceError) -> (Void)) {
        if successCase {
            onSuccess(mockResponse)
        } else {
            onError(.searchFailed)
        }
    }
}
