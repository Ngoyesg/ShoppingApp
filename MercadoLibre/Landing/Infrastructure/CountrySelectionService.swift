//
//  CountrySelectionService.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 26/08/22.
//

import Foundation

protocol CountrySelectionServiceProtocol: AnyObject {
    func getCountries(onSuccess: @escaping ([SitesAPIResponse]) -> Void, onError: @escaping (WebServiceError) -> Void)
}

class CountrySelectionService {
    
    enum Error: Swift.Error {
        case URLRequestError, webClientError
    }
    
    let urlRequestBuilder: URLRequestBuilderProtocol
    let restClient: WebClientProtocol
    
    init(urlRequestBuilder: URLRequestBuilderProtocol, restClient: WebClientProtocol) {
        self.urlRequestBuilder = urlRequestBuilder
        self.restClient = restClient
    }
    
    func processResponse(
        responseToDecode: Data,
        onSuccess: @escaping ([SitesAPIResponse]) -> Void,
        onError: @escaping (WebServiceError) -> Void) {
            
            let decoder = JSONDecoder()
            
            do {
                let decodifiedResponse = try decoder.decode([SitesAPIResponse].self, from: responseToDecode)
                onSuccess(decodifiedResponse)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                onError(.errorDecodingData)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                onError(.errorDecodingData)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                onError(.errorDecodingData)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                onError(.errorDecodingData)
            } catch {
                print("error: ", error)
                onError(.errorDecodingData)
            }
        }
    
    func performRequest(request: URLRequest, onSuccess: @escaping ([SitesAPIResponse]) -> Void, onError: @escaping (WebServiceError) -> Void) {
        restClient.performRequest(request: request) { [weak self] dataToDecode in
            guard let self = self else {
                return
            }
            self.processResponse(responseToDecode: dataToDecode, onSuccess: onSuccess, onError: onError)
        } onError: {  [weak self] errorThrown in
            guard let self = self else {
                return
            }
            onError(errorThrown)
        }
    }
}

extension CountrySelectionService: CountrySelectionServiceProtocol {
    
    func getCountries(onSuccess: @escaping ([SitesAPIResponse]) -> Void, onError: @escaping (WebServiceError) -> Void) {
        
        do {
            let endpoint = SitesSearch()
            self.urlRequestBuilder.setEndpoint(endpoint: endpoint)
            let request = try urlRequestBuilder.build()
            performRequest(request: request, onSuccess: onSuccess, onError: onError)
        } catch let errorThrown {
            onError(.searchFailed)
        }
    }
}


