//
//  ProductViewModel.swift
//  Shopify
//
//  Created by Mai Atef  on 16/02/2025.
//

import Foundation
class ProductViewModel{
    
        
        var bindProductsToViewController: (() -> ()) = {}
    var finalResult: [ProductModel] = []{
            didSet {
                bindProductsToViewController()
            }
        }
      

            
    func getProductsFromModel(query: String) {
        ApolloProductsNetwokService.shared.fetchProducts(query: query) { [weak self] result in
            switch result {
            case .success(let data):
                if let products = data.data?.products.edges {
                    self?.finalResult  = products.map { edge in
                        let product = edge.node
                        return ProductModel(price: Double(product.priceRange.maxVariantPrice.amount), currencyCode: product.priceRange.maxVariantPrice.currencyCode.rawValue,
                                            image: product.featuredImage?.url,title: product.title,vendor: product.vendor)
                    }
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    }



