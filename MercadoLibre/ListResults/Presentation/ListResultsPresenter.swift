//
//  ListResultsPresenter.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

protocol ListResultsPresenterProtocol: AnyObject {
    func setViewController(_ viewController: ListResultsViewControllerProtocol)
    func sendRequest()
    func getNumberOfRows()-> Int
    func getItem(for row: Int) -> ProductsToDisplay
    func itemWasSelected(at row: Int)
    func getThumbnail(for row: Int) -> Data?
}

class ListResultsPresenter {
    
    enum Error: Swift.Error {
        case incompleteDataToSearch, noResults, errorShowingData
    }
    
    weak var viewController: ListResultsViewControllerProtocol?
    
    var searchItemUseCase: SearchItemUseCaseProtocol
    var preconditionVerifierUseCase: PreconditionVerifierUseCaseProtocol
    
    var itemSearchResults: [ProductsToDisplay] = []
    
    init(searchItemUseCase: SearchItemUseCaseProtocol, preconditionVerifierUseCase: PreconditionVerifierUseCaseProtocol){
        self.searchItemUseCase = searchItemUseCase
        self.preconditionVerifierUseCase = preconditionVerifierUseCase
    }
}

extension ListResultsPresenter: ListResultsPresenterProtocol {
    
    func setViewController(_ viewController: ListResultsViewControllerProtocol){
        self.viewController = viewController
        self.viewController?.startSpinner()
    }
    
    func sendRequest() {
        preconditionVerifierUseCase.getPreconditions { [weak self] preconditions in
            guard let self = self else {
                return
            }
            self.searchItem(with: preconditions)
        } onError: { [weak self] errorThrown in
            guard let self = self, let controller = self.viewController else {
                return
            }
            controller.alertInitializationFailed()
        }
    }
    
    func searchItem(with endpointInfo: EndpointInfo) {
        guard itemSearchResults.count == 0 else {
            return
        }
        
        searchItemUseCase.executeSearch(with: endpointInfo) { [weak self] productsData in
            guard let self = self, let controller = self.viewController else {
                return
            }
            self.itemSearchResults = productsData
            controller.stopSpinner()
            controller.showTable()
            controller.reloadTableView()
        } onError: { [weak self] errorThrown in
            guard let self = self, let controller = self.viewController else {
                return
            }
            controller.stopSpinner()
            controller.alertDownloadingFailed()
        }
    }
    
    func getNumberOfRows()-> Int{
        return itemSearchResults.count
    }
    func getItem(for row: Int) -> ProductsToDisplay {
        return itemSearchResults[row]
    }
    
    func getThumbnail(for row: Int) -> Data? {
        return itemSearchResults[row].thumbnail
    }
    
    func itemWasSelected(at row: Int){
        let selectedItem = itemSearchResults[row]
        guard let controller = self.viewController else {
            return
        }
        controller.navigateToDetailedResultScreen(with: selectedItem)
    }
}
