//
//  LocationPickerUseCaseTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import XCTest
@testable import MercadoLibre

class LocationPickerUseCaseTests: XCTestCase {

    private var sut: LocationPickerUseCase!
    private var fakeListCountriesService: FakeListCountriesService!
    
    override func setUp() {
        super.setUp()
        fakeListCountriesService = FakeListCountriesService()
        sut = LocationPickerUseCase(listCountriesService: fakeListCountriesService)
    }
    
    override func tearDown() {
        fakeListCountriesService = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_executeIsCalled_GIVEN_aSuccessCase_THEN_itShouldReturnASiteAPIResponse(){
        fakeListCountriesService.successCase = true
        
        let expectedResponse = [SitesAPIResponse(name: "Country", id: "CountryID")]
        
        sut.execute { response in
            XCTAssertEqual(response, expectedResponse)
        } onError: { _ in
            XCTFail()
        }
    }
    
    func test_WHEN_executeIsCalled_GIVEN_aFailedCase_THEN_itShouldThrowError(){
        fakeListCountriesService.successCase = false
                
        sut.execute { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown, WebServiceError.searchFailed)
        }
    }
}
