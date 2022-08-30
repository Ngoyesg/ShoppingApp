//
//  CountryIDSelectionManager.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation

protocol CountryIDSelectionManagerProtocol: AnyObject {
    func saveCountrySite(with id: String)
    func getCountryID() throws -> String
}

class CountryIDSelectionManager {
    
    struct Constant {
        static let userDefaultCountryID = "siteID"
    }
    
    enum Error: Swift.Error {
        case noCountry
    }
}
    
extension CountryIDSelectionManager: CountryIDSelectionManagerProtocol {
    
    func saveCountrySite(with id: String) {
        let store = UserDefaults.standard
        store.set(id, forKey: Constant.userDefaultCountryID)
    }
    
    func getCountryID() throws -> String  {
        let store = UserDefaults.standard
        let title = store.value(forKey: Constant.userDefaultCountryID) as? String
        
        if let title = title {
            return title
        } else {
            throw CountryIDSelectionManager.Error.noCountry
        }
    }
    
}
