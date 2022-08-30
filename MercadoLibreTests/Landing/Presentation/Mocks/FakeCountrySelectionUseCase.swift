//
//  FakeCountrySelectionUseCase.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeCountrySelectionUseCase: CountrySelectionUseCaseProtocol {
    
    var countryIdWasSaved = false
    
    var successCase = false
    
    func saveCountrySite(with contryID: String) {
        countryIdWasSaved = true
    }
    
    func verifyCountrySelection(onSuccess: @escaping (Bool) -> (Void), onError: @escaping (CountryIDSelectionManager.Error) -> (Void)) {
        if successCase {
            onSuccess(true)
        } else {
            onError(.noCountry)
        }
    }
}
