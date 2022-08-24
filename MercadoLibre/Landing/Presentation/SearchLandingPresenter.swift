//
//  SearchLandingPresenter.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

protocol SearchLandingPresenterProtocol: AnyObject {
    func processSearchClicked(for item: String?)
    func setViewController(_ viewController: SearchLandingViewControllerProtocol)
}

class SearchLandingPresenter {
    
    enum Error: Swift.Error {
        case emptySearch
    }
   
    weak var viewController: SearchLandingViewControllerProtocol?
    
    var searchUseCase: SearchUseCaseProtocol

    init(searchUseCase: SearchUseCaseProtocol){
        self.searchUseCase = searchUseCase
    }
}

extension SearchLandingPresenter: SearchLandingPresenterProtocol {
   
    func setViewController(_ viewController: SearchLandingViewControllerProtocol){
        self.viewController = viewController
    }
    
    func processSearchClicked(for item: String?) {
        self.searchUseCase.execute(search: item) { [weak self] productToSearch in
            guard let self = self, let viewController = self.viewController else {
                return
            }
            viewController.setItemToSearch(as: productToSearch)
            viewController.navigateToListResultsScreen()
        } onError: { [weak self] errorThrown in
            guard let self = self, let viewController = self.viewController else {
                return
            }
            print(errorThrown.localizedDescription)
            viewController.alertSearchWasEmpty()
        }
    }
}
