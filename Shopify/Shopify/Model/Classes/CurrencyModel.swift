//
//  CurrencyModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 22/02/2025.
//

import Foundation

struct CurrencyModel : Codable{
    var meta : Meta?
    var data : [String : Currency]?
}
struct Meta :Codable{
    let last_updated_at : String?
}
struct Currency : Codable{
    var code : String?
    var value : Double?
}
