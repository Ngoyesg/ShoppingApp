//
//  QAsAPIResponse.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 26/08/22.
//

import Foundation


struct QAsAPIResponse: Codable {
    let questions: [Question]
}

struct Question: Codable {
    let question: String?
    let answer: Answer?
    let date: String?
    
    private enum CodingKeys: String, CodingKey {
        case question = "text", answer, date = "date_created"
    }
}

struct Answer: Codable {
    let text: String?
}
