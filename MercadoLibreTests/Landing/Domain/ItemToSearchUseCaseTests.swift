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
        sut = nil
        fakeItemToSearchManager = nil
        super.tearDown()
    }
    
    func test_WHEN_verifyItemToSearchIsCalled_GIVEN_aValidItemLikeiPhone_THEN_itemWasSavedShouldBeTrue(){
        let anyValidValue = "iPhone"
        sut.verifyItemToSearch(for: anyValidValue) {
            XCTAssertTrue(self.fakeItemToSearchManager.itemWasSaved)
        } onError: { _ in
            XCTFail()
        }
    }
    
//
//    func verifyItemToSearch(for item: String?, onSuccess: @escaping ()-> (Void), onError: @escaping (SearchLandingPresenter.Error)->(Void)){
//
//        guard let item = item else {
//            onError(.emptySearch)
//            return
//        }
//        guard item != "" else {
//            onError(.emptySearch)
//            return
//        }
//        itemToSearchManager.saveItem(with: item)
//        onSuccess()
//    }
    
}
