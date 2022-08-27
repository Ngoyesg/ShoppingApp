//
//  ListResultsPresenterBuilder.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

class ListResultsPresenterBuilder {
    
    func build() -> ListResultsPresenterProtocol {
        
        let restClient = RESTClient()
        
        let urlRequestBuilder = URLRequestBuilder()
        
        let fetchCountryID = FetchCountryID()
        
        let listProductService = ListProductsService(urlRequestBuilder: urlRequestBuilder, restClient: restClient, fetchCountryID: fetchCountryID)
        
        let getThumbnailService = GetThumbnailsDataService(restClient: restClient)
        
        let searchItemUseCase = SearchItemUseCase(listProductsService: listProductService, getThumbnailsService: getThumbnailService)
        
        return ListResultsPresenter(searchItemUseCase: searchItemUseCase)
    }
}
