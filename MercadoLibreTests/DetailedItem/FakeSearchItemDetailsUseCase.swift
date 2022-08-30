//
//  FakeSearchItemDetailsUseCase.swift
//  MercadoLibreTests
//
//  Created by Natalia Goyes on 30/08/22.
//

import Foundation
@testable import MercadoLibre

class FakeSearchItemDetailsUseCase: SearchItemDetailsUseCaseProtocol {
    
    var successCase = false
    let mockedResponse = QAsAPIResponse(questions: [Question(question: "anyquestion", answer: Answer(text: "anyAnswer"), date: "anydate")])
    
    func execute(search itemID: String, onSuccess: @escaping (QAsAPIResponse) -> (Void), onError: @escaping (WebServiceError) -> (Void)) {
        if successCase {
            onSuccess(mockedResponse)
        } else {
            onError(.searchFailed)
        }
        
    }
}
