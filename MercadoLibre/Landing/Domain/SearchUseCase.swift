//
//  SearchUseCase.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

protocol SearchUseCaseProtocol: AnyObject {
    func execute(search item: String?, onSuccess: @escaping (String)-> (Void), onError: @escaping (SearchLandingPresenter.Error)->(Void))
}

class SearchUseCase: SearchUseCaseProtocol {
    func execute(search item: String?, onSuccess: @escaping (String)-> (Void), onError: @escaping (SearchLandingPresenter.Error)->(Void)){
        
        guard let item = item, item != "" else {
            onError(SearchLandingPresenter.Error.emptySearch)
            return
        }
        onSuccess(item)
    }
}
