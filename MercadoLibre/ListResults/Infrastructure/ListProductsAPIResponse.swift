//
//  ListProductsAPIResponse.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 23/08/22.
//

import Foundation

struct ListProductsAPIResponse: Codable {
    let results: [ItemResults]
}

struct ItemResults: Codable {
    let id: String
    let title: String
    let price: Double
    let currency: String?
    let thumbnail: String
    let availableQuantity: Int?
    let soldQuantity: Int?
    let installments: InstallmentInfo?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, price, installments, currency = "currency_id", thumbnail, availableQuantity = "available_quantity", soldQuantity = "sold_quantity"
    }
}

struct InstallmentInfo: Codable {
    let amount: Double?
    let quantity: Int?
}

