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
    
    static func fetchCartById(cartId : String,completion: @escaping (Result<GraphQLResult<FetchCartByIdQuery.Data>, Error>) -> Void) {
        ApolloNetwokService.shared.apollo.fetch(query: FetchCartByIdQuery(id: cartId),cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func updateLineBy(cartID : String?,lineQuantuty : Int? , lineID : String? , merchandiseId : String?,completion: @escaping (Result<GraphQLResult<CartLinesUpdateMutation.Data>, Error>) -> Void) {
        ApolloNetwokService.shared.apollo.perform(mutation: CartLinesUpdateMutation(cartId: cartID!, lineQuantity: lineQuantuty!, lineId: lineID!, merchandiseId: merchandiseId!)) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func DeleteLineBy(cartID : String?,lineID : [String]?,completion: @escaping (Result<GraphQLResult<CartLinesRemoveMutation.Data>, Error>) -> Void) {
        ApolloNetwokService.shared.apollo.perform(mutation: CartLinesRemoveMutation(cartId: cartID!, linesIds: lineID!)){ result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
