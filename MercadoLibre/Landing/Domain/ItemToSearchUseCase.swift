//
//  ItemToSearchUseCase.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

protocol ItemToSearchUseCaseProtocol: AnyObject {
    func verifyItemToSearch(for item: String?, onSuccess: @escaping ()-> (Void), onError: @escaping (SearchLandingPresenter.Error)->(Void))
}

class ItemToSearchUseCase {
    
    let itemToSearchManager: ItemToSearchManagerProtocol
    
    init(itemToSearchManager: ItemToSearchManagerProtocol) {
        self.itemToSearchManager = itemToSearchManager
    }
}


extension ItemToSearchUseCase :ItemToSearchUseCaseProtocol {
    func verifyItemToSearch(for item: String?, onSuccess: @escaping ()-> (Void), onError: @escaping (SearchLandingPresenter.Error)->(Void)){
        
        guard let item = item, item != "" else {
            onError(.emptySearch)
            return
        }
        itemToSearchManager.saveItem(with: item)
        onSuccess()
    }

}
