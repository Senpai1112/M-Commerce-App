//
//  ProductDetailsViewModel.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 13/02/2025.
//

import Foundation
import MyApi

class ProductDetailsViewModel {
    private let apollo = ApolloNetwokService.shared.apollo
   // var productId: String?
    var onProductFetched: ((Product) -> Void)?
    var onError: ((String) -> Void)?
    
//    init(productId: String?) {
//            self.productId = productId
//        }

    func fetchProduct(pid: String) {
        apollo.fetch(query: ProductDetailsQuery(id: pid)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let graphQLResult):
                    if let productData = graphQLResult.data?.product {
                        let product = Product(from: productData)
                        self?.onProductFetched?(product) 
                    } else {
                        self?.onError?("Failed to load product")
                    }
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}
