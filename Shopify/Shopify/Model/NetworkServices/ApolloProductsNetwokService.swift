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
    
    func fetchCollections(completion: @escaping (Result<GraphQLResult<GetAllCollectionsQuery.Data>, Error>) -> Void) {
        ApolloNetwokService.shared.apollo.fetch(query: GetAllCollectionsQuery()) { result in
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
        ApolloNetwokService.shared.apollo.fetch(query: productsQuery) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
     func fetchCustomerOrders(token : String,completion: @escaping (Result<GraphQLResult<CustomerOrdersQuery.Data>, Error>) -> Void) {
         ApolloNetwokService.shared.apollo.fetch(query: CustomerOrdersQuery(token: token),cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
   
}
