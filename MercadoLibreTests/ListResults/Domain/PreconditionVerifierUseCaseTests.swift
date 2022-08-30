//
//  PreconditionVerifierUseCaseTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import XCTest
@testable import MercadoLibre

class PreconditionVerifierUseCaseTests: XCTestCase {

    private var sut: PreconditionVerifierUseCase!
    private var fakeItemToSearchManager: FakeItemToSearchManager!
    private var fakeCountryIDSelectionManager: FakeCountryIDSelectionManager!
    
    override func setUp() {
        super.setUp()
        fakeItemToSearchManager = FakeItemToSearchManager()
        fakeCountryIDSelectionManager = FakeCountryIDSelectionManager()
        sut = PreconditionVerifierUseCase(itemToSearchManager: fakeItemToSearchManager, countryIDSelectionManager: fakeCountryIDSelectionManager)
    }
    
    override func tearDown() {
        fakeItemToSearchManager = nil
        fakeCountryIDSelectionManager = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_getPreconditionsIsCalled_GIVEN_failedCountrySelectionCase_THEN_itShouldThrowIncompleteDataToSearch(){
        fakeCountryIDSelectionManager.successCase = false
        fakeItemToSearchManager.successCase = true
        sut.getPreconditions { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as ListResultsPresenter.Error, ListResultsPresenter.Error.incompleteDataToSearch)
        }
    }
    
    func test_WHEN_getPreconditionsIsCalled_GIVEN_failedItemToSearchCase_THEN_itShouldThrowIncompleteDataToSearch(){
        fakeCountryIDSelectionManager.successCase = true
        fakeItemToSearchManager.successCase = false
        sut.getPreconditions { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as ListResultsPresenter.Error, ListResultsPresenter.Error.incompleteDataToSearch)
        }
    }
    
    func test_WHEN_getPreconditionsIsCalled_GIVEN_successCaseOnBothServices_THEN_itShouldReturnEndpointInformation(){
        fakeCountryIDSelectionManager.successCase = true
        fakeItemToSearchManager.successCase = true
        let expectedResponse = EndpointInfo(item: "anyItem", marketID: "anyCountryID")
        sut.getPreconditions { precondition in
            XCTAssertEqual(precondition,expectedResponse)
        } onError: { errorThrown in
            XCTFail()
        }
    }
}
