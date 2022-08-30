//
//  SearchItemUseCaseTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import XCTest
@testable import MercadoLibre

class SearchItemUseCaseTests: XCTestCase {
    
    private var sut: SearchItemUseCase!
    private var fakeListProductsService: FakeListProductsService!
    private var fakeGetProductsToDisplayService: FakeGetProductsToDisplayService!
    
    override func setUp() {
        super.setUp()
        fakeGetProductsToDisplayService = FakeGetProductsToDisplayService()
        fakeListProductsService = FakeListProductsService()
        sut = SearchItemUseCase(listProductsService: fakeListProductsService, getProductsToDisplayService: fakeGetProductsToDisplayService)
    }
    
    override func tearDown() {
        fakeGetProductsToDisplayService = nil
        fakeListProductsService = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_executeSearchIsCalled_GIVEN_onSuccessCaseOnThumnailServiceAndFailedListProductService_THEN_itShouldThrowWebServiceError(){
        let anyValidEndpointInfo = EndpointInfo(item: "any", marketID: "any")
        fakeListProductsService.successCase = false
        fakeGetProductsToDisplayService.successCase = true
        sut.executeSearch(with: anyValidEndpointInfo) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
    
    func test_WHEN_executeSearchIsCalled_GIVEN_failedCaseOnThumbailServiceAndFailedListProductService_THEN_itShouldThrowWebServiceError(){
        let anyValidEndpointInfo = EndpointInfo(item: "any", marketID: "any")
        fakeListProductsService.successCase = false
        fakeGetProductsToDisplayService.successCase = false
        sut.executeSearch(with: anyValidEndpointInfo) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
    
    
    func test_WHEN_executeSearchIsCalled_GIVEN_onSuccessCaseOnListProductServiceAndFailedListProductService_THEN_itShouldThrowWebServiceError(){
        let anyValidEndpointInfo = EndpointInfo(item: "any", marketID: "any")
        fakeListProductsService.successCase = true
        fakeGetProductsToDisplayService.successCase = false
        sut.executeSearch(with: anyValidEndpointInfo) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
    
    func test_WHEN_executeSearchIsCalled_GIVEN_onSuccessCaseOnBothServices_THEN_itShouldREturnProductsToDisplay(){
        let anyValidEndpointInfo = EndpointInfo(item: "any", marketID: "any")
        fakeListProductsService.successCase = true
        fakeGetProductsToDisplayService.successCase = true
        sut.executeSearch(with: anyValidEndpointInfo) { response in
            XCTAssertEqual(response, self.fakeGetProductsToDisplayService.mockedResponse)
        } onError: { _ in
            XCTFail()
        }
    }
    
}
