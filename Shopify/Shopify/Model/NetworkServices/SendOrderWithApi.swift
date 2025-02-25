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
    
    static func fetchOrderAndSendEmail(shopifyAccessToken: String,completion: @escaping (Result<GraphQLResult<CustomerOrdersQuery.Data>, Error>) -> Void) {
        // 🕒 Adding delay to ensure order is processed before fetching
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            ApolloNetwokService.shared.apollo.fetch(query: CustomerOrdersQuery(token: shopifyAccessToken)) { result in
                switch result {
                case .success(let graphQLResult):
                    /*guard let order = graphQLResult.data?.customer?.orders.edges.last?.node else {
                        completion(.failure(NSError(domain: "ShopifyError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Order not found"])))
                        return
                    }
                    
                    let customerEmail = UserDefaults.standard.string(forKey: "customerEmail") ?? "email error"
                    let customerName = UserDefaults.standard.string(forKey: "customerName") ?? "error in name"
                    let items = order.lineItems.edges.map { $0.node.title }.joined(separator: ", ")
                    
                    sendEmailViaBrevoSMTP(toEmail: customerEmail,
                                          subject: "Your Order Details",
                                          body: "Hello \(customerName), your order includes: \(items).",
                                          completion: completion)
                     */
                    completion(.success(graphQLResult))
                    print("✅ orders Fetched Successfully")
                case .failure(let error):
                    print("❌ Failed to fetch order: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }
    
    /*private static func sendEmailViaBrevo(toEmail: String, subject: String, body: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://api.brevo.com/v3/emailCampaigns"
        
        let headers: HTTPHeaders = [
            "api-key": "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",
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "sender": [
                "name": "Cartique",
                "email": "youssabyasser@gmail.com"
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
    }*/
}
