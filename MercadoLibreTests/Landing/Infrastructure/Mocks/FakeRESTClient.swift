//
//  FakeRESTClient.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeRESTClient: WebClientProtocol {

    var successCase = false
    var performRequestWasCalled = false
    var caller = ""
    
    private func getEncodedSiteData() -> Data {
        let mockSucess = [SitesAPIResponse(name: "Colombia", id: "MCO")]
        let encoder = JSONEncoder()
        let encodedData = try! encoder.encode(mockSucess.self)
        return encodedData
    }
    
    private func getEncodedListProductsData() -> Data {
        let mockSucess = ListProductsAPIResponse(results: [ItemResults(id: "any", title: "any", price: 1.0, currency: "COP", thumbnail: "anythumbnailURL", availableQuantity: 1, soldQuantity: 1, installments: InstallmentInfo(amount: 1.0, quantity: 1))])
        let encoder = JSONEncoder()
        let encodedData = try! encoder.encode(mockSucess.self)
        return encodedData
    }
    
    private func getEncodedQandAsData() -> Data {
        let mockSucess = QAsAPIResponse(questions: [Question(question: "anyQuestion", answer: Answer(text: "anyAnswer"), date: "anyDate")])
        let encoder = JSONEncoder()
        let encodedData = try! encoder.encode(mockSucess.self)
        return encodedData
    }
        
    private func getUndecodableData() -> Data {
        let mockFailed = [SitesAPIResponse(name: "Colombia", id: "")]
        let encoder = JSONEncoder()
        let encodedData = try! encoder.encode(mockFailed.self)
        return encodedData
    }
    
    func getDataToRetrieve() -> Data {
        if caller == "site" {
            return getEncodedSiteData()
        } else if caller == "productsList" {
            return getEncodedListProductsData()
        } else if caller == "thumbnails" {
            return Data()
        } else if caller == "qAndAs" {
            return getEncodedQandAsData()
        } else {
            fatalError()
        }
    }
    
    func performRequest(request: URLRequest, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void) {
        performRequestWasCalled = true
        
        if (successCase) {
            let dataToReturn = getDataToRetrieve()
            onSuccess(dataToReturn)
        } else {
            onError(WebServiceError.searchFailed)
        }
    }
}
