//
//  SendOrderWithApi.swift
//  Shopify
//
//  Created by Yasser Yasser on 25/02/2025.
//

import Foundation
import Alamofire
import MyApi
import Apollo

class SendOrderWithApi{
    
    // Fetch order details and send email
    
//    static func fetchCustomerOrders(token : String,completion: @escaping (Result<GraphQLResult<CustomerOrdersQuery.Data>, Error>) -> Void) {
//        ApolloNetwokService.shared.apollo.fetch(query: CustomerOrdersQuery(token: token),cachePolicy: .fetchIgnoringCacheData) { result in
//           switch result {
//           case .success(let graphQLResult):
//               completion(.success(graphQLResult))
//           case .failure(let error):
//               completion(.failure(error))
//           }
//       }
//   }
    
    static func fetchOrderAndSendEmail(shopifyAccessToken: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        ApolloNetwokService.shared.apollo.fetch(query: CustomerOrdersQuery(token: shopifyAccessToken)) { [self] result in
            switch result {
            case .success(let graphQLResult):
                guard (graphQLResult.data?.customer?.orders.edges.last?.node.id) != nil
                else {return}
                if let order = graphQLResult.data?.customer?.orders.edges.last?.node {
                    let customerEmail = UserDefaults.standard.string(forKey: "customerEmail")
                    let customerName = UserDefaults.standard.string(forKey: "customerName")
                    let items = order.lineItems.edges.map{$0.node.title}.joined(separator: ", ")
                    sendEmailViaBrevo(toEmail: customerEmail ?? "email error", subject: "Your Order Details",body: "Hello \(customerName ?? "error in name"), your order includes: \(items).", completion: completion)
                } else {
                    completion(.failure(NSError(domain: "ShopifyError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Order not found"])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Send email via SendGrid

    private static func sendEmailViaBrevo(toEmail: String, subject: String, body: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://api.brevo.com/v3/smtp/email"
        
        let headers: HTTPHeaders = [
            "api-key": "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",
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "sender": [
                "name": "Cartique",
                "email": "youssabyasser@gmail.com" // Replace with your verified sender email
            ],
            "to": [
                ["email": toEmail]
            ],
            "subject": subject,
            "htmlContent": body
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
