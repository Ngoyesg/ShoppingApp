//
//  PreconditionVerifierUseCase.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation

protocol PreconditionVerifierUseCaseProtocol: AnyObject {
    func getPreconditions(onSuccess: @escaping (EndpointInfo)-> (Void), onError: @escaping (ListResultsPresenter.Error)->(Void))
}

class PreconditionVerifierUseCase {
    
    let itemToSearchManager: ItemToSearchManagerProtocol
    let countryIDSelectionManager: CountryIDSelectionManagerProtocol
    
    init(itemToSearchManager: ItemToSearchManagerProtocol, countryIDSelectionManager: CountryIDSelectionManagerProtocol) {
        self.itemToSearchManager = itemToSearchManager
        self.countryIDSelectionManager = countryIDSelectionManager
    }
    
}

extension PreconditionVerifierUseCase: PreconditionVerifierUseCaseProtocol {
    func getPreconditions(onSuccess: @escaping (EndpointInfo)-> (Void), onError: @escaping (ListResultsPresenter.Error)->(Void)) {
        do {
            let siteID = try self.countryIDSelectionManager.getCountryID()
            let itemToSearch = try self.itemToSearchManager.getItem()
            let precondition = EndpointInfo(itemToSearch, siteID)            
            onSuccess(precondition)
        } catch {
            onError(.incompleteDataToSearch)
        }
       
        
    }
}
