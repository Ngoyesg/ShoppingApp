//
//  SearchLandingPresenterBuilder.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

class SearchLandingPresenterBuilder {
    
    func build() -> SearchLandingPresenterProtocol {
        
        let searchUseCase = SearchUseCase()
        
        return SearchLandingPresenter(searchUseCase: searchUseCase)
    }
    
}
