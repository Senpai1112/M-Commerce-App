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
      
    func mapCost(amount: String?, currencyCode: String?) -> Double? {
            guard let amount = amount else { return nil }
            let doubleCost = (Double(amount) ?? 0.0) * UserDefaults.standard.double(forKey: "currencyValue")
            let formattedPrice = (doubleCost * 100).rounded() / 100
            return formattedPrice
        }
            
    func getProductsFromModel(query: String) {
        ApolloProductsNetwokService.fetchProducts(query: query) { [weak self] result in
            switch result {
            case .success(let data):
                if let products = data.data?.products.edges {
                    self?.finalResult  = products.map { edge in
                        let product = edge.node
                        return ProductModel(id: product.id, price: self?.mapCost(
                            amount: product.priceRange.maxVariantPrice.amount,
                            currencyCode: product.priceRange.maxVariantPrice.currencyCode.rawValue
                        ) ?? 0.0, currencyCode: UserDefaults.standard.string(forKey: "currencyCode") ?? "",
                                            image: product.featuredImage?.url,title: product.title,vendor: product.vendor)
                    }
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    }



