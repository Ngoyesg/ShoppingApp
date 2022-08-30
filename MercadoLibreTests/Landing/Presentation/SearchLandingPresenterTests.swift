//
//  SearchLandingPresenterTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import XCTest
@testable import MercadoLibre

class SearchLandingPresenterTests: XCTestCase {
    
    private var sut: SearchLandingPresenter!
    var fakeItemToSearchUseCase: FakeItemToSearchUseCase!
    var fakeLocationPickerUseCase: FakeLocationPickerUseCase!
    var fakeCountrySelectionUseCase: FakeCountrySelectionUseCase!
   
    
    override func setUp() {
        super.setUp()
        fakeItemToSearchUseCase = FakeItemToSearchUseCase()
        fakeLocationPickerUseCase = FakeLocationPickerUseCase()
        fakeCountrySelectionUseCase = FakeCountrySelectionUseCase()
        sut = SearchLandingPresenter(itemToSearchUseCase: fakeItemToSearchUseCase, locationPickerUseCase: fakeLocationPickerUseCase, countrySelectionUseCase: fakeCountrySelectionUseCase)
    }
    
    override func tearDown() {
        fakeItemToSearchUseCase = nil
        fakeLocationPickerUseCase = nil
        fakeCountrySelectionUseCase = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_setViewControllerIsCalled_GIVEN_aValidViewController_THEN_itReturnTrue(){
        let fakeViewController = FakeSearchLandingViewController()
        sut.setViewController(fakeViewController)
        XCTAssertTrue(sut.viewController is SearchLandingViewControllerProtocol)
    }
    
    func test_WHEN_requestPickerInformationIsCalled_GIVEN_aSuccessCaseAndControllerSet_THEN_pickerWasReloadedShouldBeTrue() {
        
        fakeLocationPickerUseCase.successCase = true
        
        let fakeViewController = FakeSearchLandingViewController()
        sut.setViewController(fakeViewController)
        let expectedMocked = [SitesAPIResponse(name: "AnyCountry", id: "AnyId")]
        
        sut.requestPickerInformation()
        XCTAssertEqual(sut.countriesInformation, expectedMocked)
        XCTAssertTrue(fakeViewController.pickerWasReloaded)
    }
    
    func test_WHEN_requestPickerInformationIsCalled_GIVEN_aFailedCaseAndControllerSet_THEN_alertInitializationFailedShouldBeTrue() {
        
        fakeLocationPickerUseCase.successCase = false
        
        let fakeViewController = FakeSearchLandingViewController()
        sut.setViewController(fakeViewController)
        sut.requestPickerInformation()
        XCTAssertTrue(fakeViewController.alertInitFailedInitialized)
    }
    
    func test_WHEN_getRowsForPickerIsCalled_GIVEN_pickerDataWasRequestedAndControllerSet_THEN_itShouldReturnCount(){
        fakeLocationPickerUseCase.successCase = true
        let fakeViewController = FakeSearchLandingViewController()
        sut.setViewController(fakeViewController)
        sut.requestPickerInformation()
        let rows = sut.getRowsForPicker()
        XCTAssertEqual(rows, fakeLocationPickerUseCase.mockResponse.count)
    }
    
    func test_WHEN_getTitleForPickerAtRowIsCalled_GIVEN_pickerDataWasRequestedAndControllerSet_THEN_itShouldReturnTitle(){
        fakeLocationPickerUseCase.successCase = true
        let fakeViewController = FakeSearchLandingViewController()
        sut.setViewController(fakeViewController)
        sut.requestPickerInformation()
        let anyValidRow = 0
        let title = sut.getTitleForPicker(at: anyValidRow)
        XCTAssertEqual(title, fakeLocationPickerUseCase.mockResponse[anyValidRow].name)
    }
    
    func test_WHEN_countryWasSelectedIsCalled_GIVEN_pickerDataWasRequestedAndControllerSet_THEN_countryWasSavedShouldBeTrue(){
        fakeLocationPickerUseCase.successCase = true
        let fakeViewController = FakeSearchLandingViewController()
        sut.setViewController(fakeViewController)
        sut.requestPickerInformation()
        let anyValidRow = 0
        sut.countryWasSelected(at: anyValidRow)
        XCTAssertTrue(fakeCountrySelectionUseCase.countryIdWasSaved)
    }
    
    func test_WHEN_verifyItemICalled_GIVEN_aSuccessCase_THEN_navigationShouldBeTrue(){
        fakeItemToSearchUseCase.successCase = true
        let fakeViewController = FakeSearchLandingViewController()
        sut.setViewController(fakeViewController)
        let anyValidItem = "Any valid item"
        sut.verifyItemToSearch(verify: anyValidItem)
        XCTAssertTrue(fakeViewController.segueToNavigateTolistResultsScreenActivated)
    }
    
    func test_WHEN_verifyItemICalled_GIVEN_aFailedCase_THEN_alertItemIsEmptyShouldBeTrue(){
        fakeItemToSearchUseCase.successCase = false
        let fakeViewController = FakeSearchLandingViewController()
        sut.setViewController(fakeViewController)
        let anyInvalidItem: String? = nil
        sut.verifyItemToSearch(verify: anyInvalidItem)
        XCTAssertTrue(fakeViewController.alertEmptySearchInitialized)
    }
    
    
    func test_WHEN_processSearchClickedIsCalled_GIVEN_aValidItemAndCountrySelected_THEN_itShouldCallVerify() {
        let anyValidParameter: String? = "Any Item"
        fakeCountrySelectionUseCase.successCase = true
        sut.processSearchClicked(for: anyValidParameter)
        XCTAssertTrue(fakeItemToSearchUseCase.verifyWasCalled)
    }
    
    
    func test_WHEN_processSearchClickedIsCalled_GIVEN_anEmptyItemAndControllerSet_THEN_alertEmptyCountryWasEmptyShouldBeTrue() {
        let anyInvalidParameter: String? = nil
        let fakeViewController = FakeSearchLandingViewController()
        sut.setViewController(fakeViewController)
        sut.processSearchClicked(for: anyInvalidParameter)
        XCTAssertTrue(fakeViewController.alertEmptyCountryInitialized)
    }

    
}

