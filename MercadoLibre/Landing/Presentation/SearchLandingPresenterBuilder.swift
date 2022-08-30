//
//  SearchLandingPresenterBuilder.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

class SearchLandingPresenterBuilder {
    
    func build() -> SearchLandingPresenterProtocol {
        
       let countryIDSelectionManager = CountryIDSelectionManager()
        
        let countrySelectionUseCase = CountrySelectionUseCase(countryIDSelectionManager: countryIDSelectionManager)
        
        let restClient = RESTClient()
        
        let urlRequestBuilder = URLRequestBuilder()
        
        let listCountriesService = ListCountriesService(urlRequestBuilder: urlRequestBuilder, restClient: restClient)

        let locationPickerUseCase = LocationPickerUseCase(listCountriesService: listCountriesService)

        let itemToSearchManager = ItemToSearchManager()
        
        let itemToSearchUseCase = ItemToSearchUseCase(itemToSearchManager: itemToSearchManager)
        
        return SearchLandingPresenter(itemToSearchUseCase: itemToSearchUseCase, locationPickerUseCase: locationPickerUseCase, countrySelectionUseCase: countrySelectionUseCase)
    }
    
}
