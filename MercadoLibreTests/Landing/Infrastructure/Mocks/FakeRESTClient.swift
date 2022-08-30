//
//  FakeRESTClient.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeRESTClient: WebClientProtocol {

    var successCase: Bool = true
    
   
    
    private func getEncodedData() -> Data {
        let mockSucess = SitesAPIResponse(name: "Colombia", id: "MCO")
        let encoder = JSONEncoder()
        let encodedData = try! encoder.encode(mockSucess.self)
        return encodedData
    }
        
    private func getUndecodableData() -> Data {
        let mockFailed = SitesAPIResponse(name: "Colombia", id: "")
        let encoder = JSONEncoder()
        let encodedData = try! encoder.encode(mockFailed.self)
        
        return encodedData
    }
    
    func performRequest(request: URLRequest, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void) {
        
        if (successCase) {
            let dataToReturn = getEncodedData()
            onSuccess(dataToReturn)
        } else {
            onError(WebServiceError.searchFailed)
        }
    }
}
