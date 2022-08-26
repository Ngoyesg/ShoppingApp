//
//  URLRequestBuilder.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 24/08/22.
//

import Foundation

protocol URLRequestBuilderProtocol: AnyObject {
    func setEndpoint(endpoint: BaseEndpoint)
    func build() throws -> URLRequest
}

class URLRequestBuilder {
    
    enum Error: Swift.Error {
        case unauthorized, noURL, noEndpoint
    }
    
    var endpoint: BaseEndpoint?
}

extension URLRequestBuilder: URLRequestBuilderProtocol {
    
    func setEndpoint(endpoint: BaseEndpoint) {
        self.endpoint = endpoint
    }
    
    func build() throws -> URLRequest {
        
        guard let endpoint = self.endpoint else {
            throw Error.noEndpoint
        }
        
        guard let url = endpoint.getURL() else {
            throw Error.noURL
        }
        return URLRequest(url: url)
    }
}
