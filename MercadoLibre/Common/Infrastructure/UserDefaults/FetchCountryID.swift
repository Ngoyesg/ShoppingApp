//
//  FetchCountryID.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 26/08/22.
//

import Foundation

protocol FetchCountryIDProtocol: AnyObject {
    func getCountryID() throws -> String
}

class FetchCountryID {
    enum Error: Swift.Error {
        case noCountry
    }
}

extension FetchCountryID: FetchCountryIDProtocol {
    func getCountryID() throws -> String  {
        let store = UserDefaults.standard
        let title = store.value(forKey: UserDefaultConstant.countryID) as? String
        
        if let title = title {
            return title
        } else {
            throw FetchCountryID.Error.noCountry
        }
    }
}
