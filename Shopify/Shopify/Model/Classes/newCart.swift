//
//  NewCart.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 21/02/2025.
//
struct NewCart {
    var id: String
    var checkoutUrl: String?
    var createdAt: String?
    var note: String?
    var totalQuantity: Int
    var updatedAt: String?
    
    init(id: String, checkoutUrl: String?, createdAt: String?, note: String?, totalQuantity: Int, updatedAt: String?) {
        self.id = id
        self.checkoutUrl = checkoutUrl
        self.createdAt = createdAt
        self.note = note
        self.totalQuantity = totalQuantity
        self.updatedAt = updatedAt
    }
}
struct CartLineInputData {
    let quantity: Int
    let merchandiseId: String
}
