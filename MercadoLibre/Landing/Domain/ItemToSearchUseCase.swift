//
//  ItemToSearchUseCase.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

protocol ItemToSearchUseCaseProtocol: AnyObject {
    func verifyItemToSearch(verify item: String?, onSuccess: @escaping (Bool)-> (Void), onError: @escaping (ItemToSearchManager.Error)->(Void))
}

class ItemToSearchUseCase {
    
    let itemToSearchManager: ItemToSearchManagerProtocol
    
    init(itemToSearchManager: ItemToSearchManagerProtocol) {
        self.itemToSearchManager = itemToSearchManager
    }
}


extension ItemToSearchUseCase :ItemToSearchUseCaseProtocol {
    func verifyItemToSearch(verify item: String?, onSuccess: @escaping (Bool)-> (Void), onError: @escaping (ItemToSearchManager.Error)->(Void)){
        
        guard let item = item, item != "" else {
            onError(.noItemToSearch)
            return
        }
        itemToSearchManager.saveItem(with: item)
        onSuccess(true)
    }

}
