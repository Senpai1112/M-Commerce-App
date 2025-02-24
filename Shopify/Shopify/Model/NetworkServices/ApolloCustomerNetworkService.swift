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
    static func fetchCustomerDetailsFromModel(token : String?,completion: @escaping (Result<GraphQLResult<GetCustomerDetailsQuery.Data>, Error>) -> Void) {
        ApolloNetwokService.shared.apollo.fetch(query: GetCustomerDetailsQuery(token: token!),cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
