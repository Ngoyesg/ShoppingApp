//
//  ListCountriesServiceTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import XCTest
@testable import MercadoLibre

class ListCountriesServiceTests: XCTestCase {
    
    private var sut: ListCountriesService!
    private var fakeURLRequestBuilder: FakeURLRequestBuilder!
    private var fakeRESTClient: FakeRESTClient!
    
    override func setUp() {
        super.setUp()
        fakeURLRequestBuilder = FakeURLRequestBuilder()
        fakeRESTClient = FakeRESTClient()
        sut = ListCountriesService(urlRequestBuilder: fakeURLRequestBuilder, restClient: fakeRESTClient)
    }
    
    override func tearDown() {
        fakeURLRequestBuilder = nil
        fakeRESTClient = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_getCountriesIsCalled_GIVEN_aSuccessfulURLRequestAndSuccessfulRESTRequest_THEN_itShouldReturnSitesAPIResponse(){
        let expectedResponse = [SitesAPIResponse(name: "Colombia", id: "MCO")]
        fakeURLRequestBuilder.successCase = true
        fakeRESTClient.successCase = true
        fakeRESTClient.caller = "site"
        sut.getCountries { response in
            XCTAssertEqual(response, expectedResponse)
        } onError: { _ in
            XCTFail()
        }
    }
    
    func test_WHEN_getCountriesIsCalled_GIVEN_aSuccessfulURLRequestAndfFailedRESTRequest_THEN_itShouldThrowSearchFailedError(){
        fakeURLRequestBuilder.successCase = true
        fakeRESTClient.successCase = false
        sut.getCountries { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
    
    
    func test_WHEN_getCountriesIsCalled_GIVEN_aFailedURLRequestAndSuccessfulRESTRequest_THEN_itShouldThrowWebServiceError(){
        let expectedResponse = [SitesAPIResponse(name: "Colombia", id: "MCO")]
        fakeURLRequestBuilder.successCase = false
        fakeURLRequestBuilder.noEndpointCase = true
        fakeRESTClient.caller = "site"
        sut.getCountries { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
    
    func test_WHEN_getCountriesIsCalled_GIVEN_aFailedURLAndSuccessfulRESTRequest_THEN_itShouldThrowWebServiceError(){
        let expectedResponse = [SitesAPIResponse(name: "Colombia", id: "MCO")]
        fakeURLRequestBuilder.successCase = false
        fakeURLRequestBuilder.noEndpointCase = false
        fakeRESTClient.caller = "site"
        sut.getCountries { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }

}
