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
    
    func test_WHEN_getCountriesIsCalled_GIVEN_aSuccessCase_THEN_itShouldReturnSitesAPIResponse(){
       
        let expectedResponse = [SitesAPIResponse(name: "Colombia", id: "MCO")]
        
        sut.getCountries { response in
            XCTAssertEqual(response, expectedResponse)
        } onError: { _ in
            XCTFail()
        }

        
    }
    
    
    // func getCountries(onSuccess: @escaping ([SitesAPIResponse]) -> Void, onError: @escaping (WebServiceError) -> Void)
    
    
}
