//
//  ViewModel.swift
//  Shopify
//
//  Created by Mai Atef  on 09/02/2025.
//


import Foundation

class ViewModel {
    
    var bindBrandsToViewController: (() -> ()) = {}
    var finalResult: [BrandModel] = []{
        didSet {
            bindBrandsToViewController()
        }
    }

    func getBrandsFromModel() {
        ApolloNetwokService.shared.fetchCollections { [weak self] result in
            switch result {
            case .success(let data):
    if let collections = data.data?.collections.edges {
    self?.finalResult = collections.map { edge in
       let collection = edge.node
            let products = collection.products.edges.map { productEdge in
                let product = productEdge.node
            return ProductModel(title: product.title, image: product.featuredImage?.url)}
                               
        return BrandModel(title: collection.title, image: collection.image?.url, products: products)
                           }
                       }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}

