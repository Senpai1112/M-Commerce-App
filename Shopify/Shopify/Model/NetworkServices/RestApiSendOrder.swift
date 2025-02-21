//
//  RestApiSendOrder.swift
//  Shopify
//
//  Created by Yasser Yasser on 20/02/2025.
//

import Foundation

class RestApiSendOrder{
    static let shared = RestApiSendOrder()
    
    private let shopifyURL = URL(string: "https://itp-newcapital-ios3.myshopify.com/admin/api/2025-01/orders.json")!
    private let accessToken = "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"
    
    func sendOrderToShopify(jsonData: Data,compeltion : @escaping (String) -> Void){
        var request = URLRequest(url: shopifyURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "X-Shopify-Access-Token")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {

                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 201 {
                        compeltion("✅ Order successfully created!")
                    } else {
                        compeltion("Error: Received status code \(httpResponse.statusCode) ")                  }
                }

                if let data = data {
                    let responseString = String(data: data, encoding: .utf8)
                    compeltion("📨 Response: \(responseString ?? "No response")")
                }
            }
        }.resume()
    }
}
