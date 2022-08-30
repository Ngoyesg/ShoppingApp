//
//  FakeDetailsQAndAService.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeDetailsQAndAService: DetailsQAndAServiceProtocol {
    
    var successCase = false
    let mockedResponse = QAsAPIResponse(questions: [Question(question: "anyQuestion", answer: Answer(text: "anyAnswer"), date: "anyDate")])
    
    func getQuestionsAndAnswers(itemID: String, onSuccess: @escaping (QAsAPIResponse) -> Void, onError: @escaping (WebServiceError) -> Void) {
        if successCase {
            onSuccess(mockedResponse)
        } else {
            onError(.searchFailed)
        }
    }
}
