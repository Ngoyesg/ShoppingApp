//
//  DetailedItemPresenterBuilder.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 25/08/22.
//

import Foundation

class DetailedItemPresenterBuilder {
    
    func build() -> DetailedItemPresenterProtocol {
        
        let restClient = RESTClient()
        
        let urlRequestBuilder = URLRequestBuilder()
        
        let detailsQAndAService = DetailsQAndAService(urlRequestBuilder: urlRequestBuilder, restClient: restClient)
        
        let searchItemDetailUseCase = SearchItemDetailsUseCase(detailsQAndAService: detailsQAndAService)
        
        return DetailedItemPresenter(searchItemDetailUseCase: searchItemDetailUseCase)
    }
    
}
