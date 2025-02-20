//
//  ApolloCustomerNetworkService.swift
//  Shopify
//
//  Created by Yasser Yasser on 20/02/2025.
//

import Foundation
import Apollo
import MyApi

class ApolloCustomerNetworkService{
    static let shared = ApolloCustomerNetworkService()
    
    private let url = URL(string: "https://itp-newcapital-ios3.myshopify.com/api/2025-01/graphql")!
    
    private let store = ApolloStore()
    
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
    
    private(set) lazy var apollo = ApolloClient(networkTransport: networkTransport, store: store)
    
    static func fetchCustomerDetailsFromModel(token : String?,completion: @escaping (Result<GraphQLResult<GetCustomerDetailsQuery.Data>, Error>) -> Void) {
        ApolloCustomerNetworkService.shared.apollo.fetch(query: GetCustomerDetailsQuery(token: token!),cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
