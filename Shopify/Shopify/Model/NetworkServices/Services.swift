//
//  Services.swift
//  Shopify
//
//  Created by Mai Atef  on 09/02/2025.
//

import Foundation
protocol NetworkProtocol{
    func fetchBrands(completionHandler: @escaping ([SmartCollection]?) -> Void)
}
let apiKey = "1e2431fbc172bcced3e7483113009a05"
    let password = "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"
    let hostName = "itp-newcapital-ios3.myshopify.com"


class Services : NetworkProtocol {
    func fetchBrands(completionHandler: @escaping ([SmartCollection]?) -> Void) {
        
    }
    
        
    static func fetchBrands(completionHandler: @escaping ([SmartCollection]?) -> Void) {
        guard  let url = URL(string: "https://\(apiKey):\(password)@\(hostName)/admin/api/2025-01/smart_collections.json?") else {
            completionHandler(nil)
            return
        }

        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler(nil)
                return
            }

            do {
                let result = try JSONDecoder().decode(SmartCollectionResponse.self, from: data)
                completionHandler(result.smart_collections)
            } catch {
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }

        task.resume()
    }

    
    
}
    
