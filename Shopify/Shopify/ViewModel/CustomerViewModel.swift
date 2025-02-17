////
////  CustomerViewModel.swift
////  Shopify
////
////  Created by Rokaya El Shahed on 16/02/2025.
////

import Apollo
import MyApi
import Foundation

class CustomerViewModel {
    
    private let apollo = ApolloNetwokService.shared.apollo

    var onCustomerCreated: ((Customer) -> Void)?
    var onError: ((String) -> Void)?

    func createCustomer(id: String, firstName: String, lastName: String, email: String, password: String) {
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
                
                if let errors = graphQLResult.data?.customerCreate?.customerUserErrors, !errors.isEmpty {
                    // Extract errors and notify
                    let errorMessages = errors.map {
                        let errorCode = $0.code?.rawValue ?? "Unknown Error"
                        return "\(errorCode): \($0.message ?? "No message provided.")"
                    }

                    let errorMessage = errorMessages.joined(separator: "\n")
                    print("Customer creation failed: \(errorMessage)")
                    self?.onError?(errorMessage)
                    return
                }

                if let data = graphQLResult.data?.customerCreate?.customer {
                    let customer = Customer(
                        id: data.id,
                        firstName: data.firstName,
                        lastName: data.lastName,
                        email: data.email,
                        password: nil
                    )
                    self?.onCustomerCreated?(customer)
                } else {
                    print("Customer is nil in payload")
                    self?.onError?("Unexpected error: Customer data is missing.")
                }

            case .failure(let error):
                print("GraphQL error: \(error.localizedDescription)")
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
