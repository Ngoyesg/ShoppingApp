//
//  FakeURLRequestBuilder.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeURLRequestBuilder: URLRequestBuilderProtocol {
    
    var endpoint: BaseEndpoint?
    
    var noEndpointCase = false
    var successCase = false
        
    func setEndpoint(endpoint: BaseEndpoint) {
        self.endpoint = endpoint
    }
    
    func build() throws -> URLRequest {
        
        if successCase {
            return URLRequest(url: URL(string: "fooString")!)
        } else if noEndpointCase {
            throw URLRequestBuilder.Error.noEndpoint
        } else {
            throw URLRequestBuilder.Error.noURL
        }
    }
    
}
