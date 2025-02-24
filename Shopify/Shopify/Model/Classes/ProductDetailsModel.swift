//
//  ProductDetailsModel.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 13/02/2025.
//

import Foundation
import MyApi

struct Product {
    let id: String
    let title: String
    let description: String
    let availableForSale: Bool
    let totalInventory: Int
    let images: [String]
    let price: String
    let currency : String
    let variants: [Variant]

    init(from data: ProductDetailsQuery.Data.Product) {
            self.id = data.id
            self.title = data.title
            self.description = data.description
            self.availableForSale = data.availableForSale
            self.totalInventory = data.totalInventory ?? 0
            self.images = data.images.edges.compactMap { $0.node.src }
            
            self.variants = data.variants.edges.compactMap {
                Variant(id: $0.node.id, title: $0.node.title, price: Price(amount: $0.node.priceV2.amount, currencyCode: $0.node.priceV2.currencyCode.rawValue))
            }
            
            self.price = variants.first?.price.amount ?? "N/A"
            self.currency = variants.first?.price.currencyCode ?? "N/A"
        }
    }

struct Variant {
        let id: String
        let title: String
        let price: Price
    }

   

// Price Model
struct Price {
    let amount: String
    let currencyCode: String
}
