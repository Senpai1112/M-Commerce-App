//
//  CustomerAccessTokenViewModel.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 17/02/2025.
//
import Apollo
import RokayaAPI
import Foundation

class AuthViewModel {
private let apollo = ApolloNetwokService.shared.apollo

    var onLoginSuccess: ((CustomerAccessToken) -> Void)?
    var onError: ((String) -> Void)?

   
    func loginCustomer(email: String, password: String) {
        print("Attempting to log in with email: \(email)")
        
        apollo.perform(mutation: CustomerAccessTokenCreateMutation(email: email, password: password)) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                if let errors = graphQLResult.data?.customerAccessTokenCreate?.customerUserErrors, !errors.isEmpty {
                    let errorMessages = errors.map {
                        let errorCode = $0.code?.rawValue ?? "Unknown Error"
                        return "\(errorCode): \($0.message ?? "No message provided.")"
                    }
                    let errorMessage = errorMessages.joined(separator: "\n")
                    print("Login Failed: \(errorMessage)")
                    self?.onError?(errorMessage)
                    return
                }

                if let token = graphQLResult.data?.customerAccessTokenCreate?.customerAccessToken?.accessToken {
                    print("Login Successful! Access Token: \(token)")
                    let accessToken = CustomerAccessToken(accessToken: token)
                    self?.onLoginSuccess?(accessToken)
                } else {
                    print("Login failed: No access token returned.")
                    self?.onError?("Unexpected error: Access token is missing.")
                }

            case .failure(let error):
                print("GraphQL error: \(error.localizedDescription)")
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
