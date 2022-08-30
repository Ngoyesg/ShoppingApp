//
//  FakeDetailedItemViewController.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeDetailedItemViewController: DetailedItemViewControllerProtocol {
 
    var viewWasFilledWithData = false
    var alertResultsAreEmptyInitialized = false
    var alertDownloadFailedInitialized = false
    var tableIsHidden = true
    var spinnerIsActive = false
    var tableHasReloaded = false
    
    func fillViewElements(with productInfo: ProductsToDisplay) {
        viewWasFilledWithData = true
    }
    
    func alertResultsAreEmpty() {
        alertResultsAreEmptyInitialized = true
    }
    
    func alertDownloadingFailed() {
        alertDownloadFailedInitialized = true
    }
    
    func showTable() {
        tableIsHidden = false
    }
    
    func startSpinner() {
        spinnerIsActive = true
    }
    
    func stopSpinner() {
        spinnerIsActive = false
    }
    
    func reloadTableView() {
        tableHasReloaded = true
    }

}
