//
//  Ordars.swift
//  Shopify
//
//  Created by Mai Atef  on 19/02/2025.
//

import Foundation

struct CustomerOrders {
    let orders: [Orders]
}

struct Orders {
    let id: String?
    let lineItems: [OrderItem]
    let price: Double?
    let currencyCode : String?
    
    let processedAt : String?
}
struct OrderItem {
    let title: String?
    let quantity: Int?
    let variant: String?
    let image: String?
}
