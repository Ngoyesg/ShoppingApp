//
//  SearchItemUseCase.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 24/08/22.
//

import Foundation

protocol SearchItemUseCaseProtocol: AnyObject {
    func execute(search item: String, onSuccess: @escaping ([ProductsToDisplay])-> (Void), onError: @escaping (WebServiceError)->(Void))
}

class SearchItemUseCase {
    
    var thumbnailsData : [Data?] = []
    var productsToReturn: [ProductsToDisplay] = []
    
    let listProductsService: ListProductsServiceProtocol
    let getThumbnailsService: GetThumbnailsDataServiceProtocol
    
    init(listProductsService: ListProductsServiceProtocol, getThumbnailsService: GetThumbnailsDataServiceProtocol) {
        self.listProductsService = listProductsService
        self.getThumbnailsService = getThumbnailsService
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
    
    func mapProductsResults(from item: ItemResults, and thumbnail: Data) -> ProductsToDisplay {
        return ProductsToDisplay(id: item.id, title: item.title, prices: item.price, currency: item.currency ?? "NaN", thumbnail: thumbnail, quantityOfInstallments: item.installments.quantity, installments: item.installments.amount ?? 0, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity )
    }
    
    func processResults(from list: ListProductsAPIResponse, onSuccess: @escaping ()-> (Void), onError: @escaping (WebServiceError)-> (Void)) {
        list.results.forEach { itemFound in
            self.getThumbnail(search: itemFound.thumbnail) {  [weak self]  dataForImage in
                guard let self = self else {
                    return
                }
                let newProductInfo = self.mapProductsResults(from: itemFound, and: dataForImage)
                self.productsToReturn.append(newProductInfo)
                onSuccess()
            } onError: { [weak self]  webRequestError in
                guard let self = self else {
                    return
                }
                onError(.searchFailed)
            }
        }
    }
                    
}

extension SearchItemUseCase: SearchItemUseCaseProtocol {
    
    func execute(search item: String, onSuccess: @escaping ([ProductsToDisplay])-> (Void), onError: @escaping (WebServiceError)->(Void)){
        
        listProductsService.getProductsInformation(item: item) { [weak self] listProductsInformation in
            guard let self = self else {
                return
            }
            self.processResults(from: listProductsInformation) {
                onSuccess(self.productsToReturn)
            } onError: { _ in
                onError(.searchFailed)
            }

        } onError: {  [weak self] webRequestError in
            guard let self = self else {
                return
            }
            onError(.searchFailed)
        }
    }
    
 
    
}
