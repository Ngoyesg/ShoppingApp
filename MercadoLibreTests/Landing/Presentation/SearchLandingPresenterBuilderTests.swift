//
//  SearchLandingPresenterBuilderTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 29/08/22.
//

import XCTest
@testable import MercadoLibre

class SearchLandingPresenterBuilderTests: XCTestCase {

    private var sut: SearchLandingPresenterBuilder!
    
    override func setUp() {
        super.setUp()
        sut = SearchLandingPresenterBuilder()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_buildIsCalled_THEN_itShouldReturnLandingPresenter() {
        let presenter = sut.build()
        XCTAssertTrue(presenter is SearchLandingPresenter)
    }
}
