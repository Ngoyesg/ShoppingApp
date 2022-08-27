//
//  SearchLandingPresenterBuilder.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

class SearchLandingPresenterBuilder {
    
    func build() -> SearchLandingPresenterProtocol {
        
        let searchUseCase = SearchUseCase()
        
        let restClient = RESTClient()
        
        let urlRequestBuilder = URLRequestBuilder()
        
        let fetchCountryID = FetchCountryID()
        
        let saveCountryID = SaveCountryID()
        
        let countrySelectionService = CountrySelectionService(urlRequestBuilder: urlRequestBuilder, restClient: restClient)
        
        let locationPickerUseCase = LocationPickerUseCase(countrySelectionService: countrySelectionService)
        
        return SearchLandingPresenter(searchUseCase: searchUseCase, locationPickerUseCase: locationPickerUseCase, fetchCountryID: fetchCountryID, saveCountryID: saveCountryID)
    }
    
}
