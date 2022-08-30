//
//  CountrySelectionUseCaseTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import XCTest
@testable import MercadoLibre

class CountrySelectionUseCaseTests: XCTestCase {
    
    private var sut: CountrySelectionUseCase!
    private var fakeCountryIDSelectionManager: FakeCountryIDSelectionManager!
    
    override func setUp() {
        super.setUp()
        fakeCountryIDSelectionManager = FakeCountryIDSelectionManager()
        sut = CountrySelectionUseCase(countryIDSelectionManager: fakeCountryIDSelectionManager)
    }
    
    override func tearDown() {
        fakeCountryIDSelectionManager = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_saveCountryIsCalled_GIVEN_aValidParameterLikeMCO_THEN_countrySavedShouldBeTrue(){
        let anyValidParameter = "MCO"
        sut.saveCountrySite(with: anyValidParameter)
        XCTAssertTrue(self.fakeCountryIDSelectionManager.successCase)
    }
    
    func test_WHEN_verifyCountrySelectionIsCalled_GIVEN_aSuccessCase_THEN_itShouldReturnTrue(){
        fakeCountryIDSelectionManager.successCase = true
        sut.verifyCountrySelection { response in
            XCTAssertTrue(response)
        } onError: { _ in
            XCTFail()
        }
    }
    
    func test_WHEN_verifyCountrySelectionIsCalled_GIVEN_aFailedCase_THEN_itShouldThrowNoCountryError() {
        fakeCountryIDSelectionManager.successCase = false

        sut.verifyCountrySelection { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as CountryIDSelectionManager.Error, CountryIDSelectionManager.Error.noCountry)
        }
    }
 
}
