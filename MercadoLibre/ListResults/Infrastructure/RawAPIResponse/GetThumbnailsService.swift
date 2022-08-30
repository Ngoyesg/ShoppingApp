//
//  GetThumbnailsService.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 24/08/22.
//

import Foundation

protocol GetThumbnailsDataServiceProtocol: AnyObject {
    func getThumbnail(from text: String, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void)
}

class GetThumbnailsDataService {
    
    enum Error: Swift.Error {
        case URLRequestError, webClientError
    }
    
    let restClient: WebClientProtocol
    
    init(restClient: WebClientProtocol) {
        self.restClient = restClient
    }
}

extension GetThumbnailsDataService: GetThumbnailsDataServiceProtocol {
    
    func getThumbnail(from text: String, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: text)!)
        
        restClient.performRequest(request: urlRequest) { [weak self] dataFromRequest in
            guard let self = self else {
                return
            }
            onSuccess(dataFromRequest)
        } onError: {  [weak self] errorThrown in
            guard let self = self else {
                return
            }
            onError(errorThrown)
        }
    
    }
}

