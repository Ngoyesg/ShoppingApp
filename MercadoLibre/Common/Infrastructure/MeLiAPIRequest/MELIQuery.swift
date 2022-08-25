//
//  MELIQuery.swift
//  MercadoLibre
//
//  Created by Natalia Goyes on 24/08/22.
//

import Foundation

enum QueryType: String {
    case searchItem, searchSite
}

struct UserQuery {
    let queryType: QueryType
    let itemToSearch: String
}
