//
//  Network.swift
//  Shopify
//
//  Created by Yasser Yasser on 11/02/2025.
//
import Foundation
import Apollo
import MyApi

class ApolloAddressesNetwokService {
    
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
    
    static func fetchCustomerAddresses(token : String,completion: @escaping (Result<GraphQLResult<CustomerAddressesQuery.Data>, Error>) -> Void) {
        ApolloAddressesNetwokService.shared.apollo.fetch(query: CustomerAddressesQuery(token: token),cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    static func fetchCustomerDefaultAddresses(token : String,completion: @escaping (Result<GraphQLResult<CustomerDefaultAddressQuery.Data>, Error>) -> Void) {
        ApolloAddressesNetwokService.shared.apollo.fetch(query: CustomerDefaultAddressQuery(token: token),cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func deleteCustomerAddresses(token : String,addressid : String ,completion: @escaping (Result<GraphQLResult<CustomerAddressDeleteMutation.Data>, Error>) -> Void) {
        ApolloAddressesNetwokService.shared.apollo.perform(mutation: CustomerAddressDeleteMutation(token: token, addressId: addressid)) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func createCustomerAddresses(token : String,address : Addresses ,completion: @escaping (Result<GraphQLResult<CustomerAddressCreateMutation.Data>, Error>) -> Void) {
        ApolloAddressesNetwokService.shared.apollo.perform(mutation: CustomerAddressCreateMutation(
            token: token,
            address1: address.address1!,
            address2: address.address2!,
            city: address.city!,
            country: address.country!,
            phone: address.phone!)) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

