//
//  SearchLandingPresenter.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

protocol SearchLandingPresenterProtocol: AnyObject {
    func setViewController(_ viewController: SearchLandingViewControllerProtocol)
    func requestPickerInformation()
    func getRowsForPicker() -> Int
    func getTitleForPicker(at row: Int) -> String
    func countryWasSelected(at row: Int)
    func processSearchClicked(for item: String?)
}

class SearchLandingPresenter {
    
    enum Error: Swift.Error {
        case emptySearch, emptyCountry
    }
   
    weak var viewController: SearchLandingViewControllerProtocol?
    
    var itemToSearchUseCase: ItemToSearchUseCaseProtocol
    var locationPickerUseCase: LocationPickerUseCaseProtocol
    var countrySelectionUseCase: CountrySelectionUseCaseProtocol
    
    var countriesInformation: [SitesAPIResponse] = []

    init(itemToSearchUseCase: ItemToSearchUseCaseProtocol, locationPickerUseCase: LocationPickerUseCaseProtocol, countrySelectionUseCase: CountrySelectionUseCaseProtocol){
        self.itemToSearchUseCase = itemToSearchUseCase
        self.locationPickerUseCase = locationPickerUseCase
        self.countrySelectionUseCase = countrySelectionUseCase
    }
    
}


extension SearchLandingPresenter: SearchLandingPresenterProtocol {
   
    func setViewController(_ viewController: SearchLandingViewControllerProtocol){
        self.viewController = viewController
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
            viewController.alertInitializationFailed()
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
        self.countrySelectionUseCase.saveCountrySite(with: countryId)
    }
    
   func verifyItemToSearch(verify item: String?){
       self.itemToSearchUseCase.verifyItemToSearch(verify: item) { _ in
           guard let viewController = self.viewController else {
               return
           }
           viewController.navigateToListResultsScreen()
       } onError: { [weak self] errorThrown in
           guard let self = self, let viewController = self.viewController else {
               return
           }
           viewController.alertSearchWasEmpty()
       }
    }
    
    func processSearchClicked(for item: String?) {
        self.countrySelectionUseCase.verifyCountrySelection { [weak self] _ in
            guard let self = self else {
                return
            }
            self.verifyItemToSearch(verify: item)
        } onError: { [weak self] errorThrown in
            guard let self = self, let viewController = self.viewController else {
                return
            }
            viewController.alertCountryIsEmpty()
        }
    }
    
}
