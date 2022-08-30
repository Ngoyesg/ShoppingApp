//
//  CountryIDSelectionManagerTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import XCTest
@testable import MercadoLibre

class CountryIDSelectionManagerTests: XCTestCase {

    private var sut: CountryIDSelectionManager!
    
    override func setUp() {
        super.setUp()
        sut = CountryIDSelectionManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_saveCountrySiteIsCalled_GIVEN_aValidParameter_THEN_itShouldBeEqualToValueFetched(){
        let siteIDToSave = "anySiteID"
        sut.saveCountrySite(with: siteIDToSave)
        do {
            let fetchedItem = UserDefaults.standard.value(forKey: CountryIDSelectionManager.Constant.userDefaultCountryID) as! String
            XCTAssertEqual(siteIDToSave, fetchedItem)
        } catch {
            XCTFail()
        }
    }
    
    func test_WHEN_getCountryIDIsCalled_GIVEN_aValidSavedParameter_THEN_itShouldBeEqualToSavedValue(){
        let siteIDToSave = "anySiteID"
        UserDefaults.standard.set(siteIDToSave, forKey:CountryIDSelectionManager.Constant.userDefaultCountryID)
        do {
            let fetchedItem = try sut.getCountryID()
            XCTAssertEqual(siteIDToSave, fetchedItem)
        } catch {
            XCTFail()
        }
    }
    
    func test_WHEN_getCountryIDIsCalled_GIVEN_noIDSaved_THEN_itShouldThrowNoCountryError(){
         do {
            let _ = try sut.getCountryID()
             XCTFail()
        } catch let errorThrown {
            XCTAssertEqual(errorThrown as! CountryIDSelectionManager.Error, CountryIDSelectionManager.Error.noCountry)
        }
    }
}
