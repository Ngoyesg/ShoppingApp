//
//  SaveCountryID.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 26/08/22.
//

import Foundation

protocol SaveCountryIDProtocol: AnyObject {
    func saveCountrySite(with id: String?)
}

class SaveCountryID: SaveCountryIDProtocol {
    func saveCountrySite(with id: String?) {
        let store = UserDefaults.standard
        store.set(id, forKey: UserDefaultConstant.countryID)
    }
}
