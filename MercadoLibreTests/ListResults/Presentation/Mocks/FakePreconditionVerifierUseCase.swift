//
//  FakePreconditionVerifierUseCase.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import Foundation
@testable import MercadoLibre

class FakePreconditionVerifierUseCase: PreconditionVerifierUseCaseProtocol {
    
    var successCase = false
    let mockedPrecondition = EndpointInfo(item: "anyItem", marketID: "anyMarketID")
    
    func getPreconditions(onSuccess: @escaping (EndpointInfo) -> (Void), onError: @escaping (ListResultsPresenter.Error) -> (Void)) {
        if successCase {
            onSuccess(mockedPrecondition)
        } else {
            onError(.incompleteDataToSearch)
        }
    }
}
