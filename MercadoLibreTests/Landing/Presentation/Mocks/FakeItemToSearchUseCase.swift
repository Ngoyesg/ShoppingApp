//
//  FakeSearchUseCase.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeItemToSearchUseCase: ItemToSearchUseCaseProtocol {
    
    var successCase = false
    var verifyWasCalled = false
    
    func verifyItemToSearch(verify item: String?, onSuccess: @escaping (Bool) -> (Void), onError: @escaping (ItemToSearchManager.Error) -> (Void)) {
        
        verifyWasCalled = true
        
        if successCase {
            onSuccess(true)
        } else {
            onError(.noItemToSearch)
        }
        
    }

    
}

