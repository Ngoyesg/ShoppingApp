//
//  ItemToSearchUseCaseTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import XCTest
@testable import MercadoLibre

class ItemToSearchUseCaseTests: XCTestCase {

    private var sut: ItemToSearchUseCase!
    private var fakeItemToSearchManager: FakeItemToSearchManager!
    
    override func setUp() {
        super.setUp()
        fakeItemToSearchManager = FakeItemToSearchManager()
        sut = ItemToSearchUseCase(itemToSearchManager: fakeItemToSearchManager)
    }
    
    override func tearDown() {
        fakeItemToSearchManager = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_verifyItemToSearchIsCalled_GIVEN_aValidItemLikeiPhone_THEN_itemWasSavedShouldBeTrue(){
        let anyValidValue = "iPhone"
        sut.verifyItemToSearch(verify: anyValidValue) { _ in
            XCTAssertTrue(self.fakeItemToSearchManager.itemWasSaved)
        } onError: { _ in
            XCTFail()
        }
    }
    
//    func test_WHEN_verifyItemToSearchIsCalled_GIVEN_anInvalidItemLikeNil_THEN_itShouldThrowError() {
//        let anyInvalidValue = ""
//        sut.verifyItemToSearch(verify: anyInvalidValue) { _ in
//            XCTFail()
//        } onError: { errorThrown in
//            XCTAssertEqual(errorThrown is ItemToSearchManager.Error, ItemToSearchManager.Error.noItemToSearch)
//        }
//    }
}
