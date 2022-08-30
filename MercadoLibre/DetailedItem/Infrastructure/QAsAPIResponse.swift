//
//  QAsAPIResponse.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 26/08/22.
//

import Foundation


struct QAsAPIResponse: Codable, Equatable {
    let questions: [Question]
}

struct Question: Codable, Equatable {
    let question: String?
    let answer: Answer?
    let date: String?
    
    private enum CodingKeys: String, CodingKey {
        case question = "text", answer, date = "date_created"
    }
}

struct Answer: Codable, Equatable {
    let text: String?
}
