//
//  Cart.swift
//  Shopify
//
//  Created by Yasser Yasser on 18/02/2025.
//

import Foundation

struct CartResponse {
    var checkoutUrl : String?
    var id : String?
    var totalQuantity : Int?
    var totalCost : TotalCost?
    var cart : [Cart]?
}
struct TotalCost {
    var checkoutChargeAmount : Cost?
    var subtotalAmount : Cost?
    var totalAmount : Cost?
}

struct Cost {
    var amount : String?
    var currencyCode : String?
}
struct Cart {
    var id : String?
    var merchandise : Merchendise?
    var quantity : Int?
    var cost : TotalCost?
}

struct Merchendise {
    var id : String
    var availableQuantity : Int?
    var title : String?
    var image : String?
}
