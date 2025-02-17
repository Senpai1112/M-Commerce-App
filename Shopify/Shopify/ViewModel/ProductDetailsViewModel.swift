//
//  ProductDetailsViewModel.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 13/02/2025.
//

//import RokayaAPI
//import Foundation
//
//
//class ProductDetailsViewModel {
//    var product: Product?
//    var isLoading: Bool = false
//    var errorMessage: String?
//    var id: String?
//    
//    
//    
//    func fetchProduct(completion: @escaping (Result<Product, Error>) -> Void) {
//        isLoading = true
//        errorMessage = nil
//
//        let query = ProductDetailsQuery(id: id ?? "gid://shopify/Product/7226328318007")
//
//        ApolloNetwokService.shared.apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { result in
//            DispatchQueue.main.async {
//                self.isLoading = false
//
//                switch result {
//                case .success(let graphQLResult):
//                    if let productData = graphQLResult.data?.product {
//                        let product = Product(from: productData) 
//                        self.product = product
//                        completion(.success(product))
//                    } else if let errors = graphQLResult.errors {
//                        let errorString = errors.map { $0.localizedDescription }.joined(separator: "\n")
//                        self.errorMessage = errorString
//                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorString])))
//                    }
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
//}
//
//
import Foundation
import MyApi

class ProductDetailsViewModel {
    private let apollo = ApolloNetwokService.shared.apollo
    //here to pass id after merge
    var onProductFetched: ((Product) -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchProduct() {
        apollo.fetch(query: ProductDetailsQuery(id: "gid://shopify/Product/7226328318007")) { [weak self] result in
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
