//
//  ListResultsPresenterTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import XCTest
@testable import MercadoLibre

class ListResultsPresenterTests: XCTestCase {

    private var sut: ListResultsPresenter!
    private var fakeSearchItemUseCase: FakeSearchItemUseCase!
    private var fakePreconditionVerifierUseCase: FakePreconditionVerifierUseCase!
    
    override func setUp() {
        super.setUp()
        fakeSearchItemUseCase = FakeSearchItemUseCase()
        fakePreconditionVerifierUseCase = FakePreconditionVerifierUseCase()
        sut = ListResultsPresenter(searchItemUseCase: fakeSearchItemUseCase, preconditionVerifierUseCase: fakePreconditionVerifierUseCase)
    }
    
    override func tearDown() {
        fakeSearchItemUseCase = nil
        fakePreconditionVerifierUseCase = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_setViewControllerIsCalled_GIVEN_aValidViewController_THEN_itShouldReturnTrue(){
        let fakeViewController = FakeListResultsViewController()
        sut.setViewController(fakeViewController)
        XCTAssertTrue(sut.viewController is ListResultsViewControllerProtocol)
    }
    
    func test_WHEN_sendRequestIsCalled_GIVEN_failedPrecondition_THEN_alertInitFailedShouldBeTrue(){
        fakePreconditionVerifierUseCase.successCase = false
        let fakeViewController = FakeListResultsViewController()
        sut.setViewController(fakeViewController)
        sut.sendRequest()
        XCTAssertTrue(fakeViewController.alertInitFailedInitialized)
    }
    
    func test_WHEN_sendRequestIsCalled_GIVEN_succededPrecondition_THEN_searchItemShouldBeCalled(){
        fakePreconditionVerifierUseCase.successCase = true
        let fakeViewController = FakeListResultsViewController()
        sut.setViewController(fakeViewController)
        sut.sendRequest()
        XCTAssertTrue(fakeSearchItemUseCase.searchWasCalled)
    }
    
    func test_WHEN_sendRequestIsCalled_GIVEN_validPreconditionAndSearchFailed_THEN_alertDownloadFailedShouldBeTrueSpinnerShouldStop(){
        fakePreconditionVerifierUseCase.successCase = true
        fakeSearchItemUseCase.successCase = false
        let fakeViewController = FakeListResultsViewController()
        sut.setViewController(fakeViewController)
        sut.sendRequest()
        XCTAssertTrue(fakeViewController.alertDownloadFailedInitialized)
        XCTAssertFalse(fakeViewController.spinnerIsActive)
    }
    
    func test_WHEN_sendRequestIsCalled_GIVEN_validPreconditionAndValidSearch_THEN_tableActionsShouldBeTrue(){
        fakePreconditionVerifierUseCase.successCase = true
        fakeSearchItemUseCase.successCase = true
        let fakeViewController = FakeListResultsViewController()
        sut.setViewController(fakeViewController)
        sut.sendRequest()
        XCTAssertTrue(fakeViewController.tableHasReloaded)
        XCTAssertFalse(fakeViewController.spinnerIsActive)
        XCTAssertFalse(fakeViewController.tableIsHidden)
    }
    
    func test_WHEN_getNumberOfRowsIsCalled_GIVEN_dataWasRequestedAndControllerSet_THEN_itShouldReturnCount(){
        fakePreconditionVerifierUseCase.successCase = true
        fakeSearchItemUseCase.successCase = true
        let fakeViewController = FakeListResultsViewController()
        sut.setViewController(fakeViewController)
        sut.sendRequest()
        let rows = sut.getNumberOfRows()
        XCTAssertEqual(rows, fakeSearchItemUseCase.mockedProductToDisplay.count)
    }
    
    func test_WHEN_getItemIsCalled_GIVEN_dataWasRequestedAndControllerSet_THEN_itShouldReturnProductInfo(){
        fakePreconditionVerifierUseCase.successCase = true
        fakeSearchItemUseCase.successCase = true
        let fakeViewController = FakeListResultsViewController()
        sut.setViewController(fakeViewController)
        sut.sendRequest()
        let anyValidRow = 0
        let itemInfo = sut.getItem(for: anyValidRow)
        let expected = fakeSearchItemUseCase.mockedProductToDisplay[anyValidRow]
        XCTAssertEqual(itemInfo, expected)
    }

    func test_WHEN_itemWasSelected_GIVEN_dataWasRequestedAndControllerSet_THEN_navigateToDetailedItemScreenActivatedShoultBeTrue(){
        fakePreconditionVerifierUseCase.successCase = true
        fakeSearchItemUseCase.successCase = true
        let fakeViewController = FakeListResultsViewController()
        sut.setViewController(fakeViewController)
        sut.sendRequest()
        let anyValidRow = 0
        sut.itemWasSelected(at: anyValidRow)
        XCTAssertTrue(fakeViewController.segueToNavigateToDetailedItemScreenActivated)
    }

    func test_WHEN_getThumbnailIsCalled_GIVEN_aSuccessCaseInServices_THEN_itShouldReturnData(){
        fakePreconditionVerifierUseCase.successCase = true
        fakeSearchItemUseCase.successCase = true
        let fakeViewController = FakeListResultsViewController()
        sut.setViewController(fakeViewController)
        sut.sendRequest()
        let anyValidRow = 0
        let thumbnailData = sut.getThumbnail(for: anyValidRow)
        XCTAssertEqual(thumbnailData, Data())
    }
}
