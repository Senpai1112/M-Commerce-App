//
//  Orders.swift
//  Shopify
//
//  Created by Yasser Yasser on 20/02/2025.
//

import Foundation

// MARK: - Order Model

// MARK: - OrderRequest Model
struct OrderRequest: Codable {
    var order: Order
}

struct Order: Codable {
    var line_items: [LineItem]
    var customer: CustomerModel
    var billing_address: Address
    var shipping_address: Address
    var email: String
    var transactions: [Transaction]
    var financial_status: String
    var discount_codes : [CoponCodes]
}

struct CoponCodes :Codable{
    var code : String
    var amount : String
    var type : String
}

struct LineItem: Codable {
    var variant_id: Int
    var quantity: Int
}

struct CustomerModel: Codable {
    var first_name: String
    var last_name: String
    var email: String
}

struct Address: Codable {
    var address1: String
    var phone: String
    var city: String
    var country: String
}

struct Transaction: Codable {
    var kind: String
    var status: String
    var amount: Double
}
