//
//  FakeGetThumbnailsDataService.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeGetThumbnailsDataService: GetThumbnailsDataServiceProtocol {
    
    var successCase = false
    let mockedData = Data()
    
    func getThumbnail(from text: String, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void) {
        if successCase {
            onSuccess(mockedData)
        } else {
            onError(.searchFailed)
        }
    }
}
