//
//  GetThumbnailsServiceTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import XCTest
@testable import MercadoLibre

class GetThumbnailsServiceTests: XCTestCase {

    private var sut: GetThumbnailsDataService!
    private var fakeRESTClient: FakeRESTClient!
    
    override func setUp() {
        super.setUp()
        fakeRESTClient = FakeRESTClient()
        sut = GetThumbnailsDataService(restClient: fakeRESTClient)
    }
    
    override func tearDown() {
        fakeRESTClient = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_getThumbnailIsCalled_GIVEN_successfulRESTCase_THEN_itShouldReturnData(){
        let anyValidThumbnailURL = "anythumbailURL"
        fakeRESTClient.successCase = true
        fakeRESTClient.caller = "thumbnails"
        let expectedData = Data()
        
        sut.getThumbnail(from: anyValidThumbnailURL) { response in
            XCTAssertEqual(response, expectedData)
        } onError: { _ in
            XCTFail()
        }
    }

    func test_WHEN_getThumbnailIsCalled_GIVEN_failedRESTCase_THEN_itShouldReturnData(){
        let anyValidThumbnailURL = "anythumbailURL"
        fakeRESTClient.successCase = false
        
        sut.getThumbnail(from: anyValidThumbnailURL) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
}
