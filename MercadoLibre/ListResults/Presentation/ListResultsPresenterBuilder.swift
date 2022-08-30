//
//  ListResultsPresenterBuilder.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

class ListResultsPresenterBuilder {
    
    func build() -> ListResultsPresenterProtocol {

        let itemToSearchManager = ItemToSearchManager()
        
        let countryIDSelectionManager = CountryIDSelectionManager()
        
        let preconditionVerifierUseCase = PreconditionVerifierUseCase(itemToSearchManager: itemToSearchManager, countryIDSelectionManager: countryIDSelectionManager)
        
        let urlRequestBuilder = URLRequestBuilder()
        
        let restClient = RESTClient()
 
        let listProductsService = ListProductsService(urlRequestBuilder: urlRequestBuilder, restClient: restClient)
        
        let getThumbnailsService = GetThumbnailsDataService(restClient: restClient)
        
        let getProductsToDisplayService = GetProductsToDisplayService(getThumbnailsService: getThumbnailsService)
        
        let searchItemUseCase = SearchItemUseCase(listProductsService: listProductsService, getProductsToDisplayService: getProductsToDisplayService)
        
        return ListResultsPresenter(searchItemUseCase: searchItemUseCase, preconditionVerifierUseCase: preconditionVerifierUseCase)
    }
}
