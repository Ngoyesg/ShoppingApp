//
//  SearchItemUseCase.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 24/08/22.
//

import Foundation

protocol SearchItemUseCaseProtocol: AnyObject {
    func executeSearch(with endpointInfo: EndpointInfo, onSuccess: @escaping ([ProductsToDisplay])-> (Void), onError: @escaping (WebServiceError)->(Void))
}

class SearchItemUseCase {
    
    var thumbnailsData : [Data?] = []
    var productsToReturn: [ProductsToDisplay] = []
    
    let listProductsService: ListProductsServiceProtocol
    let getProductsToDisplayService: GetProductsToDisplayServiceProtocol
    
    init(listProductsService: ListProductsServiceProtocol, getProductsToDisplayService: GetProductsToDisplayServiceProtocol) {
        self.listProductsService = listProductsService
        self.getProductsToDisplayService = getProductsToDisplayService
    }
    

    func processResponse(with info: ListProductsAPIResponse, onSuccess: @escaping ([ProductsToDisplay])-> (Void), onError: @escaping (WebServiceError)->(Void)){
        
        getProductsToDisplayService.executeSearch(with: info) { [weak self] productsToReturn in
            guard let self = self else {
                return
            }
            onSuccess(productsToReturn)
        } onError: { [weak self] webRequestError in
            guard let self = self else {
                return
            }
            onError(.searchFailed)
        }
    }
}

extension SearchItemUseCase: SearchItemUseCaseProtocol {
    
    func executeSearch(with endpointInfo: EndpointInfo, onSuccess: @escaping ([ProductsToDisplay])-> (Void), onError: @escaping (WebServiceError)->(Void)){
        
        listProductsService.getProductsInformation(for: endpointInfo) { [weak self] listProductsInformation in
            guard let self = self else {
                return
            }
            self.processResponse(with: listProductsInformation, onSuccess: onSuccess, onError: onError)
        } onError: {  [weak self] webRequestError in
            guard let self = self else {
                return
            }
            onError(.searchFailed)
        }
    }
}
