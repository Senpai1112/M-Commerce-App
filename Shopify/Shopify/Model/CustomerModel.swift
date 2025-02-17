//
//  CustomerModel.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 16/02/2025.
//
import Foundation

// Customer Model
import Apollo
import RokayaAPI

//
//struct Customer: Codable {
//    let firstName: String?
//    let lastName: String?
//    let email: String
//    let phone: String?
//    let acceptsMarketing: Bool
//
//
//    init(from data: CustomerCreateMutation.Data.CustomerCreate.Customer?) {
//        self.firstName = data?.firstName
//        self.lastName = data?.lastName
//        self.email = data?.email ?? ""
//        self.phone = data?.phone
//        self.acceptsMarketing = data?.acceptsMarketing ?? false
//    }
//}
//
//
//
////  Customer Model (Represents the Created Customer)
//struct Customer {
//    let id: String?
//    let firstName: String?
//    let lastName: String?
//    let email: String?
//    let password: String?
//}



struct Customer {
    let id: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let password: String?
    let errors: [CustomerUserError]?
    
    init(id: String? = nil, firstName: String? = nil, lastName: String? = nil, email: String? = nil, password: String? = nil, errors: [CustomerUserError]? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.errors = errors
    }
}


struct CustomerUserError {
    let field: [String]?
    let message: String
}




