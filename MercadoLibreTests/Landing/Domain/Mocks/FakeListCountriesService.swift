//
//  FakeListCountriesService.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeListCountriesService: ListCountriesServiceProtocol {
    
    var successCase = false
    let mockSite = SitesAPIResponse(name: "Country", id: "CountryID")
    
    func getCountries(onSuccess: @escaping ([SitesAPIResponse]) -> Void, onError: @escaping (WebServiceError) -> Void) {
        if successCase {
            onSuccess([mockSite])
        } else {
            onError(WebServiceError.searchFailed)
        }
    }
    
    
}
