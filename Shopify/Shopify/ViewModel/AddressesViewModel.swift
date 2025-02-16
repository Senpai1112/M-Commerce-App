//
//  AddressesViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 15/02/2025.
//

import Foundation
import Apollo

class AddressesViewModel{
    var bindResultToAddressDetailsTableViewController : (()->()) = {}
    
    var finalResult = [Products]()
    {
        didSet{
            bindResultToAddressDetailsTableViewController()
        }
    }
    func getAddressesFromModel() {
        ApolloNetwokService.fetchProducts { [weak self] result in
            switch result {
            case .success(let data):
                if let collections = data.data?.products.edges {
                    let finals = collections.compactMap { $0.node }
                    let productModels = finals.map { product in
                        return Products(id: product.id, title: product.title)
                    }
                    DispatchQueue.main.async {
                        self?.finalResult = productModels
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



