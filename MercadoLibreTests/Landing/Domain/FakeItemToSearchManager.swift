//
//  FakeItemToSearchManager.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation
@testable import MercadoLibre
import UIKit

class FakeItemToSearchManager: ItemToSearchManagerProtocol {
    
    var itemWasSaved = false
    
    func saveItem(with description: String) {
        itemWasSaved = true
    }
    
    func getItem() throws -> String {
        guard let itemSaved = itemSaved else {
            throw ItemToSearchManager.Error.noItemToSearch
        }
        return itemSaved
    }

}
