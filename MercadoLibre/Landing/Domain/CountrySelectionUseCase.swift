//
//  CountrySelectionUseCase.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 29/08/22.
//

import Foundation

protocol CountrySelectionUseCaseProtocol: AnyObject {
    func saveCountrySite(with contryID: String)
    func verifyCountrySelection(onSuccess: @escaping (Bool)-> (Void), onError: @escaping (SearchLandingPresenter.Error)->(Void))
}

class CountrySelectionUseCase{
    
    var countriesData : [SitesAPIResponse] = []
    
    let countryIDSelectionManager: CountryIDSelectionManagerProtocol
    
    init(countryIDSelectionManager: CountryIDSelectionManagerProtocol) {
        self.countryIDSelectionManager = countryIDSelectionManager
    }
}

extension CountrySelectionUseCase: CountrySelectionUseCaseProtocol {
    
    func saveCountrySite(with contryID: String) {
        self.countryIDSelectionManager.saveCountrySite(with: contryID)
    }
    
    func verifyCountrySelection(onSuccess: @escaping (Bool)-> (Void), onError: @escaping (SearchLandingPresenter.Error)->(Void)){
        do {
            let _ = try self.countryIDSelectionManager.getCountryID()
            onSuccess(true)
        } catch {
            onError(.emptyCountry)
            return
        }
    }
}
