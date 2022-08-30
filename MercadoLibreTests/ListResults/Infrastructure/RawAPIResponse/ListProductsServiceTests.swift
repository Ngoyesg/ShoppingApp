//
//  ListProductsServiceTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import XCTest
@testable import MercadoLibre

class ListProductsServiceTests: XCTestCase {
    
    private var sut: ListProductsService!
    private var fakeURLRequestBuilder: FakeURLRequestBuilder!
    private var fakeRESTClient: FakeRESTClient!
    
    override func setUp() {
        super.setUp()
        fakeURLRequestBuilder = FakeURLRequestBuilder()
        fakeRESTClient = FakeRESTClient()
        sut = ListProductsService(urlRequestBuilder: fakeURLRequestBuilder, restClient: fakeRESTClient)
    }
    
    override func tearDown() {
        fakeURLRequestBuilder = nil
        fakeRESTClient = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_getProductsInformationIsCalled_GIVEN_failedURL_THEN_itShouldReturnSearchFailedError(){
       
        let anyValidEndpointInfo = EndpointInfo(item: "anyItem", marketID: "anyMarketID")
        fakeURLRequestBuilder.successCase = false
      
        sut.getProductsInformation(for: anyValidEndpointInfo) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
    
    func test_WHEN_getProductsInformationIsCalled_GIVEN_successfulURLAndRESTResponse_THEN_itShouldReturnAPIResponse(){
       
        let anyValidEndpointInfo = EndpointInfo(item: "anyItem", marketID: "anyMarketID")
        fakeURLRequestBuilder.successCase = true
        fakeRESTClient.successCase = true
        fakeRESTClient.caller = "productsList"
        
        let expectedResponse = ListProductsAPIResponse(results: [ItemResults(id: "any", title: "any", price: 1.0, currency: "COP", thumbnail: "anythumbnailURL", availableQuantity: 1, soldQuantity: 1, installments: InstallmentInfo(amount: 1.0, quantity: 1))])
        
        sut.getProductsInformation(for: anyValidEndpointInfo) { response in
            XCTAssertEqual(response, expectedResponse)
        } onError: { _ in
            XCTFail()
        }
    }
 
    func test_WHEN_getProductsInformationIsCalled_GIVEN_successfulURLAndFailedRESTResponse_THEN_itShouldReturnSearchFailedError(){
       
        let anyValidEndpointInfo = EndpointInfo(item: "anyItem", marketID: "anyMarketID")
        fakeURLRequestBuilder.successCase = true
        fakeRESTClient.successCase = false
        
        sut.getProductsInformation(for: anyValidEndpointInfo) { _ in
           XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
    
}
