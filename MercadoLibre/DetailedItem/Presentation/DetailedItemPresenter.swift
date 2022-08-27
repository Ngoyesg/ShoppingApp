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
    func requestQAndAs()
    func getNumberOfRows()-> Int
    func getQAndAs(for row: Int) -> Question?
}

class DetailedItemPresenter {
   
    weak var viewController: DetailedItemViewControllerProtocol?
   
    var dataToDisplay: ProductsToDisplay?
    
    var questionsAndAnswers: [Question?] = []
    
    var searchItemDetailUseCase: SearchItemDetailsUseCaseProtocol
    
    init(searchItemDetailUseCase: SearchItemDetailsUseCaseProtocol){
        self.searchItemDetailUseCase = searchItemDetailUseCase
    }
    
}

extension DetailedItemPresenter: DetailedItemPresenterProtocol {
    
    func setViewController(_ viewController: DetailedItemViewControllerProtocol){
        self.viewController = viewController
    }
    
    func setProductData(with information: ProductsToDisplay) {
        self.dataToDisplay = information
    }
    
    func requestQAndAs() {
        guard let itemID = dataToDisplay?.id else {
            return
        }
        viewController?.startSpinner()
        searchItemDetailUseCase.execute(search: itemID) { [weak self] apiResponse in
            guard let self = self, let controller = self.viewController else {
                return
            }
            self.questionsAndAnswers = apiResponse.questions
            controller.stopSpinner()
            controller.showTable()
            controller.reloadTableView()
        } onError: { [weak self] webServiceError in
            guard let self = self, let controller = self.viewController else {
                return
            }
            controller.stopSpinner()
            controller.alertDownloadingFailed()
        }
    }
    
    func loadView() {
        guard let controller = self.viewController else {
            return
        }
        guard let itemData = self.dataToDisplay else {
            controller.alertNoData()
            return
        }
        controller.setItemDescription(with: itemData.title)
        controller.setPrice(with: itemData.prices, currency: itemData.currency)
        controller.setInstallment(with: itemData.installments, for: itemData.quantityOfInstallments)
        
        controller.setImage(with: itemData.thumbnail)
        controller.setAvailableItems(with: itemData.availableQuantity)
        controller.setSoldItems(with: itemData.soldQuantity)
    }
    
    func getNumberOfRows()-> Int{
        return questionsAndAnswers.count
    }
    
    func getQAndAs(for row: Int) -> Question? {
        return questionsAndAnswers[row]
    }
    
}
