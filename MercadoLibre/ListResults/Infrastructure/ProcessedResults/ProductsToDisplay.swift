//
//  ProductsToDisplay.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 24/08/22.
//

import UIKit

struct ProductsToDisplay: Equatable {
    let id: String
    let title: String
    let prices: Double
    let currency: String
    let thumbnail: Data?
    let quantityOfInstallments: Int?
    let installments: Double?
    let availableQuantity: Int?
    let soldQuantity: Int?
}
