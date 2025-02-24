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
    static func fetchCustomerAddresses(token : String,completion: @escaping (Result<GraphQLResult<CustomerAddressesQuery.Data>, Error>) -> Void) {
        ApolloNetwokService.shared.apollo.fetch(query: CustomerAddressesQuery(token: token),cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    static func fetchCustomerDefaultAddresses(token : String,completion: @escaping (Result<GraphQLResult<CustomerDefaultAddressQuery.Data>, Error>) -> Void) {
        ApolloNetwokService.shared.apollo.fetch(query: CustomerDefaultAddressQuery(token: token),cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func deleteCustomerAddresses(token : String,addressid : String ,completion: @escaping (Result<GraphQLResult<CustomerAddressDeleteMutation.Data>, Error>) -> Void) {
        ApolloNetwokService.shared.apollo.perform(mutation: CustomerAddressDeleteMutation(token: token, addressId: addressid)) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func updateCustomerAddresses(token : String ,address : Addresses ,completion: @escaping (Result<GraphQLResult<CustomerAddressUpdateMutation.Data>, Error>) -> Void) {
        ApolloNetwokService.shared.apollo.perform(mutation: CustomerAddressUpdateMutation(
            token: token,
            address1: address.address1!,
            address2: address.address2!,
            city: address.city!,
            country: address.country!,
            phone: address.phone!,
            addressId: address.id!)) { result in
            switch result {
            case .success(let graphQLResult):
                completion(.success(graphQLResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    static func createCustomerAddresses(token : String,address : Addresses ,completion: @escaping (Result<GraphQLResult<CustomerAddressCreateMutation.Data>, Error>) -> Void) {
        ApolloNetwokService.shared.apollo.perform(mutation: CustomerAddressCreateMutation(
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

