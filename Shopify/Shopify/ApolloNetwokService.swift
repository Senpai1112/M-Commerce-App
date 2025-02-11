//
//  Network.swift
//  Shopify
//
//  Created by Yasser Yasser on 11/02/2025.
//
import Foundation
import Apollo

class ApolloNetwokService {
    
    static let shared = ApolloNetwokService()
    
    private let url = URL(string: "https://itp-newcapital-ios3.myshopify.com/api/2025-01/graphql")!
    
    // Create Apollo Store (for caching)
    private let store = ApolloStore()
    
    // Custom Network Transport with Headers
    private lazy var networkTransport: RequestChainNetworkTransport = {
        return RequestChainNetworkTransport(
            interceptorProvider: DefaultInterceptorProvider(store: store),
            endpointURL: url,
            additionalHeaders: [
                "X-Shopify-Storefront-Access-Token": "fab79f9e9f027819aba7284b60fdb5f3",
                "Content-Type": "application/json"
            ]
        )
    }()
    
    // Apollo Client with store and transport
    private(set) lazy var apollo = ApolloClient(networkTransport: networkTransport, store: store)
}

