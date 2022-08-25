//
//  SearchItemUseCase.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 24/08/22.
//

import Foundation

protocol SearchItemUseCaseProtocol: AnyObject {
    func execute(search item: String, onSuccess: @escaping (ListProductsAPIResponse)-> (Void), onError: @escaping (WebServiceError)->(Void))
    func getThumbnail(search thumbnail: String, onSuccess: @escaping (Data)-> (Void), onError: @escaping (WebServiceError)->(Void))
}

class SearchItemUseCase {
    
    var thumbnailsData : [Data?] = []
    
    let listProductsService: ListProductsServiceProtocol
    let getThumbnailsService: GetThumbnailsDataServiceProtocol
    
    init(listProductsService: ListProductsServiceProtocol, getThumbnailsService: GetThumbnailsDataServiceProtocol) {
        self.listProductsService = listProductsService
        self.getThumbnailsService = getThumbnailsService
    }
    
    func mapProductsResults(from list: ListProductsAPIResponse, with thumbnails: [Data?]) -> [ProductsToDisplay] {
        var products: [ProductsToDisplay] = []
        for each in 0..<list.results.count {
            let element = list.results[each]
            let newProductInfo = ProductsToDisplay(id: element.id, title: element.title, prices: element.price[0], currency: element.characteristics.currency, thumbnail: thumbnails[each])
            products.append(newProductInfo)
        }
        return products
    }
    
}

extension SearchItemUseCase: SearchItemUseCaseProtocol {
    func execute(search item: String, onSuccess: @escaping (ListProductsAPIResponse)-> (Void), onError: @escaping (WebServiceError)->(Void)){
        
        listProductsService.getProductsInformation(item: item) { [weak self] listProductsInformation in
            guard let self = self else {
                return
            }
            onSuccess(listProductsInformation)
        } onError: {  [weak self] webRequestError in
            guard let self = self else {
                return
            }
            onError(.searchFailed)
        }
    }
    
    func getThumbnail(search thumbnail: String, onSuccess: @escaping (Data)-> (Void), onError: @escaping (WebServiceError)->(Void)){
        
        getThumbnailsService.getThumbnail(from: thumbnail) { [weak self] thumbnailData in
            guard let self = self else {
                return
            }
            onSuccess(thumbnailData)
        } onError: { [weak self] webRequestError in
            guard let self = self else {
                return
            }
            onError(.searchFailed)
        }
    }
    
}
