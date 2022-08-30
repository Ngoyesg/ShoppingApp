//
//  DetailedItemPresenterTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import XCTest
@testable import MercadoLibre

class DetailedItemPresenterTests: XCTestCase {

    private var sut: DetailedItemPresenter!
    private var fakeSearchItemDetailUseCase: FakeSearchItemDetailsUseCase!
    
    override func setUp() {
        super.setUp()
        fakeSearchItemDetailUseCase = FakeSearchItemDetailsUseCase()
        sut = DetailedItemPresenter(searchItemDetailUseCase: fakeSearchItemDetailUseCase)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_setViewControllerIsCalled_GIVEN_aValidViewController_THEN_itShouldReturnTrue(){
        let fakeViewController = FakeDetailedItemViewController()
        sut.setViewController(fakeViewController)
        XCTAssertTrue(sut.viewController is DetailedItemViewControllerProtocol)
    }
    
    func test_WHEN_requestQAndAsIsCalled_GIVEN_successCaseAndValidProductChosen_THEN_tableElementsShouldReload(){
        
        let fakeViewController = FakeDetailedItemViewController()
        sut.setViewController(fakeViewController)
        fakeSearchItemDetailUseCase.successCase = true
        
        let productToDisplay = ProductsToDisplay(id: "any", title: "any", prices: 1.0, currency: "COP", thumbnail: Data(), quantityOfInstallments: 1, installments: 1.0, availableQuantity: 1, soldQuantity: 1)
        
        sut.requestQAndAs(for: productToDisplay)
        
        XCTAssertFalse(fakeViewController.spinnerIsActive)
        XCTAssertFalse(fakeViewController.tableIsHidden)
        XCTAssertTrue(fakeViewController.viewWasFilledWithData)
        XCTAssertTrue(fakeViewController.tableHasReloaded)
    }
    
    func test_WHEN_requestQAndAsIsCalled_GIVEN_failedCaseAndValidProductChosen_THEN_alertShouldBeInitialized(){
        
        let fakeViewController = FakeDetailedItemViewController()
        sut.setViewController(fakeViewController)
        fakeSearchItemDetailUseCase.successCase = false
        
        let productToDisplay = ProductsToDisplay(id: "any", title: "any", prices: 1.0, currency: "COP", thumbnail: Data(), quantityOfInstallments: 1, installments: 1.0, availableQuantity: 1, soldQuantity: 1)
        
        sut.requestQAndAs(for: productToDisplay)
        
        XCTAssertFalse(fakeViewController.spinnerIsActive)
        XCTAssertTrue(fakeViewController.alertDownloadFailedInitialized)
        XCTAssertTrue(fakeViewController.viewWasFilledWithData)
    }
    
    func test_WHEN_getNumberOfRowsIsCalled_GIVEN_successCaseAndValidProductChosen_THEN_itShouldReturnCount(){
        
        let fakeViewController = FakeDetailedItemViewController()
        sut.setViewController(fakeViewController)
        fakeSearchItemDetailUseCase.successCase = true
        
        let productToDisplay = ProductsToDisplay(id: "any", title: "any", prices: 1.0, currency: "COP", thumbnail: Data(), quantityOfInstallments: 1, installments: 1.0, availableQuantity: 1, soldQuantity: 1)
        
        sut.requestQAndAs(for: productToDisplay)
        
        let rows = sut.getNumberOfRows()
        XCTAssertEqual(rows, fakeSearchItemDetailUseCase.mockedResponse.questions.count)
    }
    
    func test_WHEN_getQAndAsIsCalled_GIVEN_successCaseAndValidProductChosen_THEN_itShouldReturnTitle(){
        
        let fakeViewController = FakeDetailedItemViewController()
        sut.setViewController(fakeViewController)
        fakeSearchItemDetailUseCase.successCase = true
        
        let productToDisplay = ProductsToDisplay(id: "any", title: "any", prices: 1.0, currency: "COP", thumbnail: Data(), quantityOfInstallments: 1, installments: 1.0, availableQuantity: 1, soldQuantity: 1)
        
        sut.requestQAndAs(for: productToDisplay)
        let anyValidRow = 0
        let qAndAs = sut.getQAndAs(for: anyValidRow)
        let expectedQAndAs = fakeSearchItemDetailUseCase.mockedResponse.questions[anyValidRow]
        XCTAssertEqual(qAndAs, expectedQAndAs)
    }
    
}
