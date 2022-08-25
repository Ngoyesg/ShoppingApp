//
//  RESTClient.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 24/08/22.
//

import Foundation

class RESTClient{
    
    private func process(
        taskResponse: (data: Data?, response: URLResponse?, error: Error?), onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void) {
            
            guard taskResponse.error == nil else {
                onError(WebServiceError.invalidRequest)
                return
            }
            guard let responseData = taskResponse.response as? HTTPURLResponse, (200..<300).contains(responseData.statusCode) else {
                onError(WebServiceError.invalidStatusCodeResponse)
                return
            }
            guard let responseToDecode = taskResponse.data else {
                onError(WebServiceError.noDataToDecode)
                return
            }
            onSuccess(responseToDecode)
    }
}
    
extension RESTClient: WebClientProtocol {
    
    func performRequest(request: URLRequest, onSuccess: @escaping (Data) -> Void, onError: @escaping (WebServiceError) -> Void) {
        
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: request as URLRequest) { [weak self] (data, respose, error) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.process(taskResponse: (data: data, response: respose, error: error), onSuccess: onSuccess, onError: onError)
            }
        }
        task.resume()
    }
}
