//
//  CustomerViewModel.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 16/02/2025.
//

import Apollo
import RokayaAPI
import Foundation


class CustomerViewModel {
    
    private let apollo = ApolloNetwokService.shared.apollo

    var onCustomerCreated: ((Customer) -> Void)?
    var onError: ((String) -> Void)?

    func createCustomer(id: String ,firstName: String, lastName: String, email: String, password: String) {
        print("Creating customer with email: \(email)")
        
        let input = Customer(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        )
        
        apollo.perform(mutation: CustomerCreateMutation(firstName: input.firstName!, lastName: input.lastName!, email: input.email!, password: input.password!)) { [weak self] result in
            print("Closure executed")
            switch result {
            case .success(let graphQLResult):
                print("GraphQL result received")
                if let payload = graphQLResult.data?.customerCreate {
                    if let gqlCustomer = payload.customer {
                        let customer = Customer(
                            id: gqlCustomer.id,
                            firstName: gqlCustomer.firstName,
                            lastName: gqlCustomer.lastName,
                            email: gqlCustomer.email,
                            password: nil
                        )
                        self?.onCustomerCreated?(customer)
                    } else {
                        print("Customer is nil in payload")
                    }
                } else {
                    print("Payload is nil")
                }
            case .failure(let error):
                print("GraphQL error: \(error.localizedDescription)")
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
