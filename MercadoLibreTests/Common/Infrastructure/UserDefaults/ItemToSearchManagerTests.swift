//
//  ItemToSearchManagerTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import XCTest
@testable import MercadoLibre

class ItemToSearchManagerTests: XCTestCase {
    
    private var sut: ItemToSearchManager!
    
    override func setUp() {
        super.setUp()
        sut = ItemToSearchManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_saveItemIsCalled_GIVEN_aValidParameter_THEN_itShouldBeEqualToValueFetched(){
        let itemToSave = "AnyItem"
        sut.saveItem(with: itemToSave)
        do {
            let fetchedItem = UserDefaults.standard.value(forKey: ItemToSearchManager.Constant.userDefaultItemToSearch) as! String
            XCTAssertEqual(itemToSave, fetchedItem)
        } catch {
            XCTFail()
        }
    }
    
    func test_WHEN_getItemIsCalled_GIVEN_aValidSavedParameter_THEN_itShouldBeEqualToSavedValue(){
        let itemToSave = "AnyItem"
        UserDefaults.standard.set(itemToSave, forKey:ItemToSearchManager.Constant.userDefaultItemToSearch)
        do {
            let fetchedItem = try sut.getItem()
            XCTAssertEqual(itemToSave, fetchedItem)
        } catch {
            XCTFail()
        }
    }
    
    func test_WHEN_getItemIsCalled_GIVEN_noItemSaved_THEN_itShouldThrowNoItemToSearchError(){
        do {
            let _ = try sut.getItem()
             XCTFail()
        } catch let errorThrown {
            XCTAssertEqual(errorThrown as! ItemToSearchManager.Error, ItemToSearchManager.Error.noItemToSearch)
        }
    }
    
}
