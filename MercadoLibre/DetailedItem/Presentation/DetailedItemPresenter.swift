//
//  DetailedItemPresenter.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 25/08/22.
//

import Foundation

protocol DetailedItemPresenterProtocol: AnyObject {
    func setViewController(_ viewController: DetailedItemViewControllerProtocol)
    func requestQAndAs(for item: ProductsToDisplay)
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
    
    func requestQAndAs(for item: ProductsToDisplay) {
        viewController?.startSpinner()
        searchItemDetailUseCase.execute(search: item.id) { [weak self] apiResponse in
            guard let self = self, let controller = self.viewController else {
                return
            }
            self.questionsAndAnswers = apiResponse.questions
            controller.stopSpinner()
            controller.fillViewElements(with: item)
            if self.questionsAndAnswers.count == 0 {
                controller.alertResultsAreEmpty()
            }
            controller.showTable()
            controller.reloadTableView()
        } onError: { [weak self] webServiceError in
            guard let self = self, let controller = self.viewController else {
                return
            }
            controller.stopSpinner()
            controller.fillViewElements(with: item)
            controller.alertDownloadingFailed()
        }
    }
    
    func getNumberOfRows()-> Int{
        return questionsAndAnswers.count
    }
    
    func getQAndAs(for row: Int) -> Question? {
        return questionsAndAnswers[row]
    }
    
}
