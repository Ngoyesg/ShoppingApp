//
//  SearchItemDetailsUseCaseTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import XCTest
@testable import MercadoLibre

class SearchItemDetailsUseCaseTests: XCTestCase {
    
    private var sut: SearchItemDetailsUseCase!
    private var fakeDetailsQAndAService: FakeDetailsQAndAService!
    
    override func setUp() {
        super.setUp()
        fakeDetailsQAndAService = FakeDetailsQAndAService()
        sut = SearchItemDetailsUseCase(detailsQAndAService: fakeDetailsQAndAService)
    }
    
    override func tearDown() {
        fakeDetailsQAndAService = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_executeIsCalled_GIVEN_successCase_THEN_itShouldReturnQandAs() {
        
        let anyValidItemID = "anyID"
        fakeDetailsQAndAService.successCase = true
        let expectedData = fakeDetailsQAndAService.mockedResponse
        
        sut.execute(search: anyValidItemID) { response in
            XCTAssertEqual(response, expectedData)
        } onError: { _ in
            XCTFail()
        }
    }
    
    func test_WHEN_executeIsCalled_GIVEN_failedCase_THEN_itShouldReturnQandAs() {
        
        let anyValidItemID = "anyID"
        fakeDetailsQAndAService.successCase = false
        
        sut.execute(search: anyValidItemID) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }

}
