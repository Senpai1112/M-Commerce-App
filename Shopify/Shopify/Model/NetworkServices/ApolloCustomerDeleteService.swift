//
//  ApolloCustomerDeleteService.swift
//  Shopify
//
//  Created by Yasser Yasser on 23/02/2025.
//

import Foundation
import MyApi
import Apollo

protocol DeleteCustomer{
    static func deleteCustomer(customerAccessToken: String?, complitionHandler: @escaping (Result<GraphQLResult<CustomerAccessTokenDeleteMutation.Data>, Error>) -> Void)
}

class ApolloCustomerDeleteService : DeleteCustomer {
    static func deleteCustomer(customerAccessToken: String?, complitionHandler: @escaping (Result<GraphQLResult<CustomerAccessTokenDeleteMutation.Data>, Error>) -> Void) {
        guard let customerAccessToken = customerAccessToken else {return}
        ApolloNetwokService.shared.apollo.perform(mutation: CustomerAccessTokenDeleteMutation(token: customerAccessToken)){ result in
            switch result {
            case .success(let result):
                complitionHandler(.success(result))
            case .failure(let error):
                complitionHandler(.failure(error))
            }
            
        }
    }
    
}
