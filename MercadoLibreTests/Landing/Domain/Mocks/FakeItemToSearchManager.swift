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
    
    func saveItem(with description: String) {
        itemWasSaved = true
    }
    
    func getItem() throws -> String {
        return ""
    }

}
