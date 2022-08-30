//
//  FakeListResultsViewController.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeListResultsViewController: ListResultsViewControllerProtocol {
    
    var alertInitFailedInitialized = false
    var alertDownloadFailedInitialized = false
    var alertNoResultsInitialized = false
    var tableIsHidden = true
    var spinnerIsActive = false
    var tableHasReloaded = false
    var segueToNavigateToDetailedItemScreenActivated = false
    
    func alertInitializationFailed() {
        alertInitFailedInitialized = true
    }
    
    func alertDownloadingFailed() {
        alertDownloadFailedInitialized = true
    }
    
    func alertNoResults() {
        alertNoResultsInitialized = true
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
    
    func navigateToDetailedResultScreen(with productInfo: ProductsToDisplay) {
        segueToNavigateToDetailedItemScreenActivated = true
    }

}
