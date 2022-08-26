//
//  BaseEndopoint.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 24/08/22.
//

import Foundation

class BaseEndpoint {
    
    let scheme: String = "https"
    let host: String = "api.mercadolibre.com"
    let path: String
    let queryItems: [URLQueryItem]
    let httpMethod: HTTPMethod
    
    init(path: String, queryItems: [URLQueryItem], httpMethod: HTTPMethod) {
        self.path = path
        self.queryItems = queryItems
        self.httpMethod = httpMethod
    }
    
    func getURL() -> URL? {
        
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        components.queryItems = self.queryItems
        
       return components.url
    }
}

class ItemSearch: BaseEndpoint {
    
    struct Constant {
        static let questIdentifier = "q"
    }
    
    init(location market: String, search item: String){
        let path = "/sites/\(market)/search"
        let queryItems = [URLQueryItem(name: Constant.questIdentifier, value: item)]
        super.init(path: path, queryItems: queryItems, httpMethod: .GET)
    }
    
}
