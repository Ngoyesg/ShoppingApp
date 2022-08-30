//
//  FakeCountryIDSelectionManager.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeCountryIDSelectionManager: CountryIDSelectionManagerProtocol {
    
    var countryWasSaved = false
    var successCase = true
    
    func saveCountrySite(with id: String) {
        countryWasSaved = true
    }
    
    func getCountryID() throws -> String {
        if successCase {
            return ""
        } else {
            throw CountryIDSelectionManager.Error.noCountry
        }
    }
    
    
}
