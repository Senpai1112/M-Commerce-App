//
//  ApolloCartNetworkService.swift
//  Shopify
//
//  Created by Yasser Yasser on 18/02/2025.
//

import Foundation
import Apollo
import MyApi

class ApolloCartNetworkService{
    static let shared = ApolloAddressesNetwokService()
    
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
    
    static func fetchCartById(cartId : String,completion: @escaping (Result<GraphQLResult<FetchCartByIdQuery.Data>, Error>) -> Void) {
        ApolloAddressesNetwokService.shared.apollo.fetch(query: FetchCartByIdQuery(id: cartId),cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func updateLineBy(cartID : String?,lineQuantuty : Int? , lineID : String? , merchandiseId : String?,completion: @escaping (Result<GraphQLResult<CartLinesUpdateMutation.Data>, Error>) -> Void) {
        ApolloAddressesNetwokService.shared.apollo.perform(mutation: CartLinesUpdateMutation(cartId: cartID!, lineQuantity: lineQuantuty!, lineId: lineID!, merchandiseId: merchandiseId!)) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func DeleteLineBy(cartID : String?,lineID : [String]?,completion: @escaping (Result<GraphQLResult<CartLinesRemoveMutation.Data>, Error>) -> Void) {
        ApolloAddressesNetwokService.shared.apollo.perform(mutation: CartLinesRemoveMutation(cartId: cartID!, linesIds: lineID!)){ result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
