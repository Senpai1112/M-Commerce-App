////
////  Orders.swift
////  Shopify
////
////  Created by Yasser Yasser on 20/02/2025.
////
//
//import Foundation
//
//// MARK: - Order Model
//struct OrderRequest: Codable {
//    let order: Order?
//}
//
//struct Order: Codable {
//    let lineItems: [LineItem]?
//    let customer: CustomerModelJson?
//    let billingAddress: Address?
//    let shippingAddress: Address?
//    let email: String?
//    let transactions: [Transaction]?
//    let financialStatus: String?
//
//    enum CodingKeys: String, CodingKey {
//        case lineItems = "line_items"
//        case customer
//        case billingAddress = "billing_address"
//        case shippingAddress = "shipping_address"
//        case email
//        case transactions
//        case financialStatus = "financial_status"
//    }
//}
//
//struct LineItem: Codable {
//    let variantID: Int?
//    let quantity: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case variantID = "variant_id"
//        case quantity
//    }
//}
//
//struct CustomerModelJson: Codable {
//    let firstName: String?
//    let lastName: String?
//    let email: String?
//
//    enum CodingKeys: String, CodingKey {
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case email
//    }
//}
//
//struct Address: Codable {
//    let firstName: String?
//    let lastName: String?
//    let address1: String?
//    let phone: String?
//    let city: String?
//    let province: String?
//    let country: String?
//    let zip: String?
//
//    enum CodingKeys: String, CodingKey {
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case address1
//        case phone
//        case city
//        case province
//        case country
//        case zip
//    }
//}
//
//struct Transaction: Codable {
//    let kind: String?
//    let status: String?
//    let amount: Double?
//}
