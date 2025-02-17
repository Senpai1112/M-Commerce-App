//
//  Brand.swift
//  Shopify
//
//  Created by Mai Atef  on 09/02/2025.
//
import Foundation

struct BrandModel {
    let title: String?
    let image: String?
    let products: [ProductModel]
}

struct ProductModel {
    let title: String?
    let image: String?
}
