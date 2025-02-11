//
//  Brand.swift
//  Shopify
//
//  Created by Mai Atef  on 09/02/2025.
//

import Foundation

struct SmartCollectionResponse: Codable {
    let smart_collections: [SmartCollection]
}

struct SmartCollection: Codable {
    let title: String?
    let image: Image?
}

struct Image: Codable {
    let src: String?
}
