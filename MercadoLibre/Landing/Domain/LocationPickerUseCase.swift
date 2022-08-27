//
//  LocationPickerUseCase.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 26/08/22.
//

import Foundation

protocol LocationPickerUseCaseProtocol: AnyObject {
    func execute(onSuccess: @escaping ([SitesAPIResponse])-> (Void), onError: @escaping (WebServiceError)->(Void))
}

class LocationPickerUseCase{
    
    var countriesData : [SitesAPIResponse] = []
    
    let countrySelectionService: CountrySelectionServiceProtocol
    
    init(countrySelectionService: CountrySelectionServiceProtocol) {
        self.countrySelectionService = countrySelectionService
    }
}

extension LocationPickerUseCase: LocationPickerUseCaseProtocol {
    func execute(onSuccess: @escaping ([SitesAPIResponse])-> (Void), onError: @escaping (WebServiceError)->(Void)){
        
        countrySelectionService.getCountries { [weak self] countriesData in
            guard let self = self else {
                return
            }
            onSuccess(countriesData)
        } onError: { [weak self] errorThrown in
            guard let self = self else {
                return
            }
            onError(.searchFailed)
        }
    }
}
