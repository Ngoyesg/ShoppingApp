//
//  DetailedItemPresenter.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 25/08/22.
//

import Foundation

protocol DetailedItemPresenterProtocol: AnyObject {
    func setViewController(_ viewController: DetailedItemViewControllerProtocol)
    func setProductData(with information: ProductsToDisplay)
    func loadView()
}

class DetailedItemPresenter {
   
    weak var viewController: DetailedItemViewControllerProtocol?
    var dataToDisplay: ProductsToDisplay?
    
}

extension DetailedItemPresenter: DetailedItemPresenterProtocol {
    
    func setViewController(_ viewController: DetailedItemViewControllerProtocol){
        self.viewController = viewController
    }
    
    func setProductData(with information: ProductsToDisplay) {
        self.dataToDisplay = information
    }
    
    func loadView() {
        guard let controller = self.viewController else {
            return
        }
        guard let itemData = self.dataToDisplay else {
            controller.alertNoData()
            return
        }
        controller.setImage(with: itemData.thumbnail)
        controller.setSoldItems(with: itemData.soldQuantity)
        controller.setAvailableItems(with: itemData.availableQuantity)
        controller.setItemDescription(with: itemData.title)
        controller.setPrice(with: itemData.prices, currency: itemData.currency)
        controller.setInstallment(with: itemData.installments, for: itemData.quantityOfInstallments)
    }
}
