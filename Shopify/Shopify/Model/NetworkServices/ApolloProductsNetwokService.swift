//
//  Network.swift
//  Shopify
//
//  Created by Yasser Yasser on 11/02/2025.
//
import Foundation
import Apollo
import MyApi

class ApolloProductsNetwokService {
    
    static let shared = ApolloProductsNetwokService()
    
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
    
    private(set) lazy var apollo = ApolloClient(networkTransport: networkTransport, store: store)
    
    func fetchCollections(completion: @escaping (Result<GraphQLResult<GetAllCollectionsQuery.Data>, Error>) -> Void) {
        ApolloProductsNetwokService.shared.apollo.fetch(query: GetAllCollectionsQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchProducts(query: String, completion: @escaping (Result<GraphQLResult<ProductsQuery.Data>, Error>) -> Void) {
        let productsQuery = ProductsQuery(query: query)
        ApolloProductsNetwokService.shared.apollo.fetch(query: productsQuery) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
     func fetchCustomerOrders(token : String,completion: @escaping (Result<GraphQLResult<CustomerOrdersQuery.Data>, Error>) -> Void) {
        ApolloAddressesNetwokService.shared.apollo.fetch(query: CustomerOrdersQuery(token: token),cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
   
}
