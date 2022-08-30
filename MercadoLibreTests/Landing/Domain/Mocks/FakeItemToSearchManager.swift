//
//  FakeItemToSearchManager.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeItemToSearchManager: ItemToSearchManagerProtocol {
    
    var itemWasSaved = false
    var successCase = false
    
    func saveItem(with description: String) {
        itemWasSaved = true
    }
    
    func getItem() throws -> String {
        if successCase {
            return "anyItem"
        } else {
            throw ItemToSearchManager.Error.noItemToSearch
        }
    }

}
