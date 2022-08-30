//
//  DetailedItemPresenterBuilderTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import XCTest
@testable import MercadoLibre

class DetailedItemPresenterBuilderTests: XCTestCase {

    private var sut: DetailedItemPresenterBuilder!
    
    override func setUp() {
        super.setUp()
        sut = DetailedItemPresenterBuilder()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_buildIsCalled_THEN_itShouldReturnDetailedItemPresenter() {
        let presenter = sut.build()
        XCTAssertTrue(presenter is DetailedItemPresenter)
    }
}
