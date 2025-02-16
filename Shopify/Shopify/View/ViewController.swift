//
//  ViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 09/02/2025.
//

import UIKit
import RokayaAPI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ApolloNetwokService.shared.apollo.fetch(query: MyQuery() ) { result in
                    switch result {
                    case .success(let graphQLResult):
                        // Check for data
                        if let data = graphQLResult.data {
                            // Access the products
                            let products = data.products.edges ?? [] // Provide a default empty array if `edges` is nil
                            for productEdge in products {
                                let product = productEdge.node // `node` is non-optional, so no need for `if let`
                                print("Product ID: \(product.id)")
                                print("Product Title: \(product.title)")

                                // Access the images
                                let images = product.images.edges ?? [] // Provide a default empty array if `edges` is nil
                                for imageEdge in images {
                                    let image = imageEdge.node // `node` is non-optional, so no need for `if let`
                                    print("Image URL: \(image.url)")
                                    print("Image Dimensions: \(image.width)x\(image.height)")
                                }
                            }
                        } else if let errors = graphQLResult.errors {
                            // Handle GraphQL errors
                            print("GraphQL Errors: \(errors)")
                        }
                    case .failure(let error):
                        // Handle network or other errors
                        print("Network Error: \(error)")
                    }
                }
    }


}

