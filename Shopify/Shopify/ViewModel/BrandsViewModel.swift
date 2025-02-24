//
//  ViewModel.swift
//  Shopify
//
//  Created by Mai Atef  on 09/02/2025.
//


import Foundation

class BrandsViewModel {
    var searchText : String = ""
    var bindBrandsToViewController: (() -> ()) = {}
    var finalResult: [BrandModel] = []{
        didSet {
            bindBrandsToViewController()
        }
    }
    func mapCost(amount: String?, currencyCode: String?) -> Double? {
            guard let amount = amount else { return nil }
            let doubleCost = (Double(amount) ?? 0.0) * UserDefaults.standard.double(forKey: "currencyValue")
            let formattedPrice = (doubleCost * 100).rounded() / 100
            return formattedPrice
        }
    
    func getBrandsFromModel() {
        ApolloProductsNetwokService.shared.fetchCollections { [weak self] result in
            switch result {
            case .success(let data):
                if let collections = data.data?.collections.edges {
                    
                    self?.finalResult = collections.map { edge in
                        let collection = edge.node
                        let products = collection.products.edges.map { productEdge in
                            let product = productEdge.node
                            return ProductModel(id: product.id, price: self?.mapCost(
                                amount: product.priceRange.maxVariantPrice.amount,
                                currencyCode: product.priceRange.maxVariantPrice.currencyCode.rawValue
                            ) ?? 0.0, currencyCode: UserDefaults.standard.string(forKey: "currencyCode") ?? "USD", image: product.featuredImage?.url,title: product.title,vendor: product.vendor)}
                        
                        return BrandModel(title: collection.title, image: collection.image?.url, products: products)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
    }

    //search filter
       var filteredCollections: [BrandModel] {
           if searchText.isEmpty {
               return finalResult
           } else {
               return finalResult.filter { brand in
                   return (brand.title?.lowercased() ?? "").contains(searchText.lowercased())
               }
           }
       }


}
