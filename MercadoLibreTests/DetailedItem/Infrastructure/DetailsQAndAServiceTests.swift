//
//  DetailsQAndAServiceTests.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import XCTest
@testable import MercadoLibre

class DetailsQAndAServiceTests: XCTestCase {

    private var sut: DetailsQAndAService!
    private var fakeURLRequestBuilder: FakeURLRequestBuilder!
    private var fakeRESTClient: FakeRESTClient!
    
    override func setUp() {
        super.setUp()
        fakeURLRequestBuilder = FakeURLRequestBuilder()
        fakeRESTClient = FakeRESTClient()
        sut = DetailsQAndAService(urlRequestBuilder: fakeURLRequestBuilder, restClient: fakeRESTClient)
    }
    
    override func tearDown() {
        fakeURLRequestBuilder = nil
        fakeRESTClient = nil
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_getQuestionsAndAnswers_GIVEN_aSuccessfulURLRequestAndSuccessfulRESTRequest_THEN_itShouldReturnQAsAPIResponse(){
        let expectedResponse = QAsAPIResponse(questions: [Question(question: "anyQuestion", answer: Answer(text: "anyAnswer"), date: "anyDate")])
        fakeURLRequestBuilder.successCase = true
        fakeRESTClient.successCase = true
        fakeRESTClient.caller = "qAndAs"
        let anyValidItemID = "anyItemId"
        
        sut.getQuestionsAndAnswers(itemID: anyValidItemID) { response in
            XCTAssertEqual(response, expectedResponse)
        } onError: { _ in
            XCTFail()
        }
    }
    
    
    func test_WHEN_getQuestionsAndAnswers_GIVEN_aSuccessfulURLRequestAndfFailedRESTRequest_THEN_itShouldThrowSearchFailedError(){
        fakeURLRequestBuilder.successCase = true
        fakeRESTClient.successCase = false
        fakeRESTClient.caller = "qAndAs"
 
        let anyValidItemID = "anyItemId"
        
        sut.getQuestionsAndAnswers(itemID: anyValidItemID) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }

    func test_WHEN_getQuestionsAndAnswers_GIVEN_aFailedURLRequestAndSuccessfulRESTRequest_THEN_itShouldThrowWebServiceError(){
        fakeURLRequestBuilder.successCase = false
        fakeURLRequestBuilder.noEndpointCase = true
        fakeRESTClient.caller = "qAndAs"
  
        let anyValidItemID = "anyItemId"
        
        sut.getQuestionsAndAnswers(itemID: anyValidItemID) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }

    func test_WHEN_getQuestionsAndAnswers_GIVEN_aFailedURLAndSuccessfulRESTRequest_THEN_itShouldThrowWebServiceError(){
        fakeURLRequestBuilder.successCase = false
        fakeURLRequestBuilder.noEndpointCase = false
        let anyValidItemID = "anyItemId"
        fakeRESTClient.caller = "qAndAs"
        
        sut.getQuestionsAndAnswers(itemID: anyValidItemID) { _ in
            XCTFail()
        } onError: { errorThrown in
            XCTAssertEqual(errorThrown as WebServiceError, WebServiceError.searchFailed)
        }
    }

}
