//
//  ProductDetailsModel.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 13/02/2025.
//

import Foundation
import RokayaAPI

struct Product {
    let id: String
    let title: String
    let description: String
    let availableForSale: Bool
    let totalInventory: Int
    let images: [String]
    let price: String
    let currecy : String
    let adjacentVariants: [Variant]

    init(from data: ProductDetailsQuery.Data.Product) {
        self.id = data.id
        self.title = data.title
        self.description = data.description
        self.availableForSale = data.availableForSale
        self.totalInventory = data.totalInventory ?? 0
        
        // Extract images
        self.images = data.images.edges.compactMap { $0.node.src }
        
        // Extract adjacent variants
        self.adjacentVariants = data.adjacentVariants.compactMap {
            Variant(price: Price(amount: $0.price.amount, currencyCode: $0.price.currencyCode.rawValue))
        }
        
        //  Extract the first price if available, otherwise set "N/A"
        self.price = adjacentVariants.first?.price.amount ?? "N/A"
        self.currecy = adjacentVariants.first?.price.currencyCode ?? "N/A"
    }
}

//  Variant Model
struct Variant {
    let price: Price
}

// Price Model
struct Price {
    let amount: String
    let currencyCode: String
}
