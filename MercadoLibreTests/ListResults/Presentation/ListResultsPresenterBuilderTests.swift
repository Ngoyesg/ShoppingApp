//
//  ListResultsPresenterBuilderTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import XCTest
@testable import MercadoLibre

class ListResultsPresenterBuilderTests: XCTestCase {

    private var sut: ListResultsPresenterBuilder!
    
    override func setUp() {
        super.setUp()
        sut = ListResultsPresenterBuilder()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_buildIsCalled_THEN_itShouldReturnLandingPresenter() {
        let presenter = sut.build()
        XCTAssertTrue(presenter is ListResultsPresenter)
    }

}
