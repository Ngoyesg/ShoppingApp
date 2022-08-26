//
//  SearchItemDetailsUseCase.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 25/08/22.
//

import Foundation

protocol SearchItemDetailsUseCaseProtocol: AnyObject {
    func execute(search itemID: String?, onSuccess: @escaping (String)-> (Void), onError: @escaping (SearchLandingPresenter.Error)->(Void))
}

class SearchItemDetailsUseCase: SearchUseCaseProtocol {
    
    func execute(search itemID: String?, onSuccess: @escaping (String) -> (Void), onError: @escaping (SearchLandingPresenter.Error) -> (Void)) {
        fatalError()
    }
    
    
}
