//
//  ProductsAndThumbnailsProcessor.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation

protocol GetProductsToDisplayServiceProtocol: AnyObject {
    func executeSearch(with productsListResponse: ListProductsAPIResponse, onSuccess: @escaping ([ProductsToDisplay])-> (Void), onError: @escaping (WebServiceError)->(Void))
}

class GetProductsToDisplayService {
    
    var productsToReturn : [ProductsToDisplay] = []
    
    let getThumbnailsService: GetThumbnailsDataServiceProtocol
    
    let dispatchGroup = DispatchGroup()
    let dipatchQueue = DispatchQueue(label: "Thumbnails")
    var error = false
    
    init(getThumbnailsService: GetThumbnailsDataServiceProtocol) {
        self.getThumbnailsService = getThumbnailsService
    }
    
    func mapProductsResults(from item: ItemResults, and thumbnail: Data) -> ProductsToDisplay {
        return ProductsToDisplay(id: item.id, title: item.title, prices: item.price, currency: item.currency!, thumbnail: thumbnail, quantityOfInstallments: item.installments?.quantity, installments: item.installments?.amount, availableQuantity: item.availableQuantity, soldQuantity: item.soldQuantity )
    }
}

extension GetProductsToDisplayService: GetProductsToDisplayServiceProtocol {
    
    func executeSearch(with productsListResponse: ListProductsAPIResponse, onSuccess: @escaping ([ProductsToDisplay])-> (Void), onError: @escaping (WebServiceError)->(Void)){
        
       error = false
   
        productsListResponse.results.forEach { itemFound in
            dipatchQueue.async {
                self.dispatchGroup.enter()
                self.getThumbnailsService.getThumbnail(from: itemFound.thumbnail) { [weak self] thumbnailData in
                    guard let self = self else {
                        return
                    }
                    let newProductToDisplay = self.mapProductsResults(from: itemFound, and: thumbnailData)
                    self.productsToReturn.append(newProductToDisplay)
                    self.dispatchGroup.leave()
                } onError: { [weak self] webRequestError in
                    guard let self = self else {
                        return
                    }
                    self.dispatchGroup.leave()
                    self.error = true
                }
            }
        }
        
        dispatchGroup.notify(queue: dipatchQueue) {
            DispatchQueue.main.async {
                if self.error {
                    onError(.searchFailed)
                } else {
                    onSuccess(self.productsToReturn)
                }
            }
        }
    }
    
}
