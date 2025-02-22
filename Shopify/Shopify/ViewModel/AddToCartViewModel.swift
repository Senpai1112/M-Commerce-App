//
//  AddToCartViewModel.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 22/02/2025.
//
import Foundation
import Apollo
import MyApi

class AddToCartViewModel {

    private let apollo = ApolloNetwokService.shared.apollo
    
    var onCartUpdated: ((NewCart) -> Void)?
    var onError: ((String) -> Void)?
    
    func addLineToCart(cartId: String, lines: [CartLineInput]) {
        print("Adding lines to cart with ID: \(cartId)")
        
        // Convert lines to GraphQL-compatible format
        let linesInput = lines.map { CartLineInput(quantity: $0.quantity, merchandiseId: $0.merchandiseId) }
        
        // Perform the mutation
        apollo.perform(mutation: CartLinesAddMutation(cartId: cartId, lines: linesInput)) { [weak self] result in
            print("Closure executed")
            switch result {
            case .success(let graphQLResult):
                print("GraphQL result received")
                
                if let errors = graphQLResult.data?.cartLinesAdd?.userErrors, !errors.isEmpty {
                    // Extract errors and notify
                    let errorMessages = errors.map {
                        let errorCode = $0.code?.rawValue ?? "Unknown Error"
                        return "\(errorCode): \($0.message ?? "No message provided.")"
                    }
                    
                    let errorMessage = errorMessages.joined(separator: "\n")
                    print("Cart update failed: \(errorMessage)")
                    self?.onError?(errorMessage)
                    return
                }
                
                if let data = graphQLResult.data?.cartLinesAdd?.cart {
                    let cart = NewCart(
                        id: data.id,
                        checkoutUrl: data.checkoutUrl,
                        createdAt: data.createdAt,
                        note: data.note,
                        totalQuantity: data.totalQuantity,
                        updatedAt: data.updatedAt
                    )
                    self?.onCartUpdated?(cart)
                } else {
                    print("Cart data is missing in payload")
                    self?.onError?("Unexpected error: Cart data is missing.")
                }
                
            case .failure(let error):
                print("GraphQL error: \(error.localizedDescription)")
                self?.onError?(error.localizedDescription)
            }
        }
    }
//    private let apollo = ApolloNetwokService.shared.apollo
//
//    var onCartUpdated: ((NewCart) -> Void)?
//    var onError: ((String) -> Void)?
//
//    func addLineToCart(cartId: String, lines: [CartLineInput]) {
//        print("Adding lines to cart with ID: \(cartId)")
//
//        // Perform the mutation
//        apollo.perform(mutation: CartLinesAddMutation(cartId: cartId, lines: lines)) { [weak self] result in
//            print("Closure executed")
//            switch result {
//            case .success(let graphQLResult):
//                print("GraphQL result received")
//
//                if let errors = graphQLResult.data?.cartLinesAdd?.userErrors, !errors.isEmpty {
//                    // Extract errors and notify
//                    let errorMessages = errors.map {
//                        let errorCode = $0.code?.rawValue ?? "Unknown Error"
//                        return "\(errorCode): \($0.message ?? "No message provided.")"
//                    }
//
//                    let errorMessage = errorMessages.joined(separator: "\n")
//                    print("Cart update failed: \(errorMessage)")
//                    self?.onError?(errorMessage)
//                    return
//                }
//
//                if let data = graphQLResult.data?.cartLinesAdd?.cart {
//                    let cart = NewCart(
//                        id: data.id,
//                        checkoutUrl: data.checkoutUrl,
//                        createdAt: data.createdAt,
//                        note: data.note,
//                        totalQuantity: data.totalQuantity,
//                        updatedAt: data.updatedAt
//                    )
//                    self?.onCartUpdated?(cart)
//                } else {
//                    print("Cart data is missing in payload")
//                    self?.onError?("Unexpected error: Cart data is missing.")
//                }
//
//            case .failure(let error):
//                print("GraphQL error: \(error.localizedDescription)")
//                self?.onError?(error.localizedDescription)
//            }
//        }
//    }
}

