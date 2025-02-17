//
//  CustomerModel.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 16/02/2025.
//
import Foundation
import Apollo
import RokayaAPI


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

struct CustomerAccessToken {
    let accessToken: String?
}


