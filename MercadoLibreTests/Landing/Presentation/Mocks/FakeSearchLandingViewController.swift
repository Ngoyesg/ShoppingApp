//
//  FakeSearchLandingViewController.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import XCTest
@testable import MercadoLibre

class FakeSearchLandingViewController: SearchLandingViewControllerProtocol {

    var searchButtonIsEnabled = false
    var segueToNavigateTolistResultsScreenActivated = false
    var alertEmptySearchInitialized = false
    var alertEmptyCountryInitialized = false
    var alertInitFailedInitialized = false
    var pickerWasReloaded = false
    
    func enableSearchButton() {
        self.searchButtonIsEnabled = true
    }
    
    func disableSearchButton() {
        self.searchButtonIsEnabled = false
    }
    
    func navigateToListResultsScreen() {
        self.segueToNavigateTolistResultsScreenActivated = true
    }
    
    func alertSearchWasEmpty() {
        self.alertEmptySearchInitialized = true
    }
    
    func alertInitializationFailed() {
        self.alertInitFailedInitialized = true
    }
    
    func alertCountryIsEmpty() {
        self.alertEmptyCountryInitialized = true
    }
    
    func reloadPicker() {
        self.pickerWasReloaded = true
    }
}

