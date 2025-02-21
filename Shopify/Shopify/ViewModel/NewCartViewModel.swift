//
//  NewCartViewModel.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 21/02/2025.
//

import Foundation
import Apollo
import MyApi

class NewCartViewModel {
    
    private let apollo = ApolloNetwokService.shared.apollo
    
    var onCartCreated: ((NewCart) -> Void)?
    var onError: ((String) -> Void)?
    
    func createCart(customerAccessToken: String) {
        print("Creating cart with customer access token: \(customerAccessToken)")
        
        apollo.perform(mutation: CartCreateMutation(customerAccessToken: customerAccessToken)) { [weak self] result in
            print("Closure executed")
            switch result {
            case .success(let graphQLResult):
                print("GraphQL result received")
                
                if let errors = graphQLResult.data?.cartCreate?.userErrors, !errors.isEmpty {
                    // Extract errors and notify
                    let errorMessages = errors.map {
                        let errorCode = $0.code?.rawValue ?? "Unknown Error"
                        return "\(errorCode): \($0.message ?? "No message provided.")"
                    }
                    
                    let errorMessage = errorMessages.joined(separator: "\n")
                    print("Cart creation failed: \(errorMessage)")
                    self?.onError?(errorMessage)
                    return
                }
                
                if let data = graphQLResult.data?.cartCreate?.cart {
                    let cart = NewCart(
                        id: data.id,
                        checkoutUrl: data.checkoutUrl,
                        createdAt: data.createdAt,
                        note: data.note,
                        totalQuantity: data.totalQuantity,
                        updatedAt: data.updatedAt
                    )
                    self?.onCartCreated?(cart)
                } else {
                    print("Cart is nil in payload")
                    self?.onError?("Unexpected error: Cart data is missing.")
                }

            case .failure(let error):
                print("GraphQL error: \(error.localizedDescription)")
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
