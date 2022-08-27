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
    func getRowsForPicker() -> Int
    func getTitleForPicker(at row: Int) -> String
    func countryWasSelected(at row: Int)
    func verifyCountrySelection() 
}

class SearchLandingPresenter {
    
    enum Error: Swift.Error {
        case emptySearch
    }
   
    weak var viewController: SearchLandingViewControllerProtocol?
    
    var searchUseCase: SearchUseCaseProtocol
    var locationPickerUseCase: LocationPickerUseCaseProtocol
    var fetchCountryID: FetchCountryIDProtocol
    var saveCountryID: SaveCountryIDProtocol
    
    var countriesInformation: [SitesAPIResponse] = []

    init(searchUseCase: SearchUseCaseProtocol, locationPickerUseCase: LocationPickerUseCaseProtocol, fetchCountryID: FetchCountryIDProtocol, saveCountryID: SaveCountryIDProtocol){
        self.searchUseCase = searchUseCase
        self.locationPickerUseCase = locationPickerUseCase
        self.fetchCountryID = fetchCountryID
        self.saveCountryID = saveCountryID
    }
}

extension SearchLandingPresenter: SearchLandingPresenterProtocol {
   
    func setViewController(_ viewController: SearchLandingViewControllerProtocol){
        self.viewController = viewController
    }
    
    func verifyCountrySelection() {
        do {
            let id = try fetchCountryID.getCountryID()
            self.viewController?.enableSearchButton()
        } catch _ {
            self.viewController?.disableSearchButton()
        }
        requestPickerInformation()
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
            viewController.alertSearchWasEmpty()
        }
    }
    
    func requestPickerInformation(){
        self.locationPickerUseCase.execute { [weak self] pickerInformation in
            guard let self = self, let viewController = self.viewController else {
                return
            }
            self.countriesInformation = pickerInformation
            viewController.reloadPicker()
        } onError: {  [weak self] errorThrown in
            guard let self = self, let viewController = self.viewController else {
                return
            }
            viewController.alertCountryIsEmpty()
        }
    }
    
    func getRowsForPicker() -> Int {
        return countriesInformation.count
    }
    
    func getTitleForPicker(at row: Int) -> String {
        return countriesInformation[row].name
    }
    
    func countryWasSelected(at row: Int){
        let countryId = countriesInformation[row].id
        self.saveCountryID.saveCountrySite(with: countryId)
        self.viewController?.enableSearchButton()
    }
}
