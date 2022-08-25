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
    let price: [Int]
    let characteristics: AdvertInfo
    
    private enum CodingKeys: String, CodingKey {
        case price = "seller", characteristics = "prices", id, title
    }
}

struct AdvertInfo: Codable {
    let currency: String
    let thumbnail: String
    
    private enum CodingKeys: String, CodingKey {
        case currency = "currency_id", thumbnail
    }
}

