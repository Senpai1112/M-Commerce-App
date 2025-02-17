//
//  Addresses.swift
//  Shopify
//
//  Created by Yasser Yasser on 15/02/2025.
//

import Foundation

class Addresses{
    var country : String?
    var city : String?
    var address1 : String?
    var address2 : String?
    var phone : String?
    var id : String?
    
    init(country: String? = nil, city: String? = nil, address1: String? = nil, address2: String? = nil, phone: String? = nil, id: String? = nil) {
        self.country = country
        self.city = city
        self.address1 = address1
        self.address2 = address2
        self.phone = phone
        self.id = id
    }
}
