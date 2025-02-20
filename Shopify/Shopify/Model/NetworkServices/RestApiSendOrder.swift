////
////  RestApiSendOrder.swift
////  Shopify
////
////  Created by Yasser Yasser on 20/02/2025.
////
//
//import Foundation
//
//class RestApiSendOrder{
//    static func sendOrderToShopify(jsonData: Data ,completion: @escaping ((Data) -> Void)) {
//        let url = URL(string: "https://itp-newcapital-ios3.myshopify.com/admin/api/2025-01/orders.json")!
//        let accessToken = "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"
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue(accessToken, forHTTPHeaderField: "X-Shopify-Access-Token")
//        request.httpBody = jsonData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let httpResponse = response as? HTTPURLResponse {
//                print("Status Code: \(httpResponse.statusCode)")
//            }
//            
//            if let data = data {
//                let responseString = String(data: data, encoding: .utf8)
//                completion(data)
//                print("Response: \(responseString ?? "No response")")
//            }
//        }
//        
//        task.resume()
//    }
//}
