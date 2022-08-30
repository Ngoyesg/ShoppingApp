//
//  GetProductsToDisplayServiceTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import XCTest
@testable import MercadoLibre

class GetProductsToDisplayServiceTests: XCTestCase {

    private var sut: GetProductsToDisplayService!
    private var fakeGetThumbnailsService: FakeGetThumbnailsDataService!
    
    override func setUp() {
        super.setUp()
        fakeGetThumbnailsService = FakeGetThumbnailsDataService()
        sut = GetProductsToDisplayService(getThumbnailsService: fakeGetThumbnailsService)
    }
    
    override func tearDown() {
        fakeGetThumbnailsService = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_executeSearchIsCalled_GIVEN_successCase_THEN_itShouldReturnArrayOfProducts(){
        let item1 = ItemResults(id: "any", title: "any", price: 1.0, currency: "COP", thumbnail: "anythumbnailURL", availableQuantity: 1, soldQuantity: 1, installments: InstallmentInfo(amount: 1.0, quantity: 1))
        let item2 = ItemResults(id: "any2", title: "any2", price: 2.0, currency: "USD", thumbnail: "anythumbnailURL2", availableQuantity: 2, soldQuantity: 2, installments: InstallmentInfo(amount: 2.0, quantity: 2))
        
        let anyValidList = ListProductsAPIResponse(results: [item1, item2])
        
        fakeGetThumbnailsService.successCase = true
        
        let product1 = ProductsToDisplay(id: "any", title: "any", prices: 1.0, currency: "COP", thumbnail: Data(), quantityOfInstallments: 1, installments: 1.0, availableQuantity: 1, soldQuantity: 1)
        let product2 = ProductsToDisplay(id: "any2", title: "any2", prices: 2.0, currency: "USD", thumbnail: Data(), quantityOfInstallments: 2, installments: 2.0, availableQuantity: 2, soldQuantity: 2)
        
        let expectedProductList = [product1, product2]
        
        sut.executeSearch(with: anyValidList) { response in
            XCTAssertEqual(response, expectedProductList)
        } onError: { _ in
            XCTFail()
        }
    }
    
    func test_WHEN_executeSearchIsCalled_GIVEN_failedCase_THEN_itShouldReturnSearchFailedError(){
        let item1 = ItemResults(id: "any", title: "any", price: 1.0, currency: "COP", thumbnail: "anythumbnailURL", availableQuantity: 1, soldQuantity: 1, installments: InstallmentInfo(amount: 1.0, quantity: 1))
        let item2 = ItemResults(id: "any2", title: "any2", price: 2.0, currency: "USD", thumbnail: "anythumbnailURL2", availableQuantity: 2, soldQuantity: 2, installments: InstallmentInfo(amount: 2.0, quantity: 2))
        
        let anyValidList = ListProductsAPIResponse(results: [item1, item2])
        
        fakeGetThumbnailsService.successCase = false
        
        sut.executeSearch(with: anyValidList) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }
}
