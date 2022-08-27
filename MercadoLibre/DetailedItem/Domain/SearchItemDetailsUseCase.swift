//
//  SearchItemDetailsUseCase.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 25/08/22.
//

import Foundation


protocol SearchItemDetailsUseCaseProtocol: AnyObject {
    func execute(search itemID: String, onSuccess: @escaping (QAsAPIResponse)-> (Void), onError: @escaping (WebServiceError)->(Void))
}

class SearchItemDetailsUseCase {
    
    let detailsQAndAService: DetailsQAndAServiceProtocol
    
    init( detailsQAndAService: DetailsQAndAServiceProtocol) {
        self.detailsQAndAService = detailsQAndAService
    }
                    
}

extension SearchItemDetailsUseCase: SearchItemDetailsUseCaseProtocol {
    
    func execute(search itemID: String, onSuccess: @escaping (QAsAPIResponse)-> (Void), onError: @escaping (WebServiceError)->(Void)){
        
        
        detailsQAndAService.getQuestionsAndAnswers(itemID: itemID) { [weak self] qAndAsInfo in
            guard let self = self else {
                return
            }
            if qAndAsInfo.questions.isEmpty {
                onSuccess(QAsAPIResponse(questions:[Question(question: "No hay pregunta", answer: Answer(text: "No hay respuesta"), date: nil)]))
            } else {
                onSuccess(qAndAsInfo)
            }
        } onError: { [weak self] webRequestError in
            guard let self = self else {
                return
            }
            onError(.searchFailed)
        }
    }
}
