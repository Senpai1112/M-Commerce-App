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



//  Customer Model (Represents the Created Customer)
struct Customer {
    let id: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let password: String?
}




