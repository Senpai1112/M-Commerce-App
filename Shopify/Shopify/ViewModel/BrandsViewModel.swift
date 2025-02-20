//
//  ViewModel.swift
//  Shopify
//
//  Created by Mai Atef  on 09/02/2025.
//


import Foundation

class BrandsViewModel {
    
    var bindBrandsToViewController: (() -> ()) = {}
    var finalResult: [BrandModel] = []{
        didSet {
            bindBrandsToViewController()
        }
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
                            return ProductModel(id: product.id, price: Double(product.priceRange.maxVariantPrice.amount), currencyCode: product.priceRange.maxVariantPrice.currencyCode.rawValue, image: product.featuredImage?.url,title: product.title,vendor: product.vendor)}
                        
                        return BrandModel(title: collection.title, image: collection.image?.url, products: products)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        

    }
       
            
}

