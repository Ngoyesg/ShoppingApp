//
//  SearchLandingPresenterTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import XCTest
@testable import MercadoLibre
/*
class SearchLandingPresenterTests: XCTestCase {
    
    private var sut: SearchLandingPresenter!
    var fakeSearchUseCase: FakeSearchUseCase!
    var fakeLocationPickerUseCase: FakeLocationPickerUseCase!
    var fakeFetchCountryID: FakeFetchCountryID!
    var fakeSaveCountryID: FakeSaveCountryID!
    
    override func setUp() {
        super.setUp()
        fakeSearchUseCase = FakeSearchUseCase()
        fakeLocationPickerUseCase = FakeLocationPickerUseCase()
        fakeFetchCountryID = FakeFetchCountryID()
        fakeSaveCountryID = FakeSaveCountryID()
        
        sut = SearchLandingPresenter(searchUseCase: fakeSearchUseCase, locationPickerUseCase: fakeLocationPickerUseCase, fetchCountryID: fakeFetchCountryID, saveCountryID: fakeSaveCountryID)
    }
    
    override func tearDown() {
        fakeSearchUseCase = nil
        fakeLocationPickerUseCase = nil
        fakeFetchCountryID = nil
        fakeSaveCountryID = nil
        
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_setViewControllerIsCalled_GIVEN_aValidViewController_THEN_itReturnTrue(){
        let fakeViewController = FakeSearchLandingViewController()
        sut.setViewController(fakeViewController)
        XCTAssertTrue(sut.viewController is SearchLandingViewController)
    }
    
    func test_WHEN_processSearchClickedIsCalled_GIVEN_anEmptyItem_THEN_alertSearchWasEmptyShouldBeTrue() {
        let anyInvalidParameter: String? = nil
        let fakeViewController = FakeSearchLandingViewController()
        sut.setViewController(fakeViewController)
        sut.processSearchClicked(for: anyInvalidParameter)
        XCTAssertTrue(fakeViewController.alertEmptySearchInitialized)
    }
    
    func test_WHEN_processSearchClickedIsCalled_GIVEN_aValidItem_THEN_itShouldReturnTheValue() {
        let anyValidParameter: String? = "Any Item"
        let expectation = XCTestExpectation(description: "it should return the unoptional value")
        
        do {
            sut.processSearchClicked(for: anyValidParameter)
            expectation.fulfill()
        } catch {
          XCTFail()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    
    //    func getRowsForPicker() -> Int
    //    func getTitleForPicker(at row: Int) -> String
    //    func countryWasSelected(at row: Int)
    //    func verifyCountrySelection()
    
}
*/
