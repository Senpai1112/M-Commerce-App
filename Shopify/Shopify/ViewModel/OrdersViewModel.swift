//
//  OrdersViewModel.swift
//  Shopify
//
//  Created by Mai Atef  on 19/02/2025.
//

import Foundation
import MyApi
class OrdersViewModel {
    
    var bindOrdersToViewController: (() -> ()) = {}
    var finalResult: [Orders] = []{
        didSet {
            bindOrdersToViewController()
        }
    }
    
    
    func getOrdersFromModel(token: String) {
        ApolloProductsNetwokService.shared.fetchCustomerOrders(token: token) { [weak self] result in
            switch result {
            case .success(let data):
                if let ordersEdges = data.data?.customer?.orders.edges {
                    
                    self?.finalResult = ordersEdges.map { edge in
                        let order = edge.node
                        return Orders(
                            price: Double(order.originalTotalPrice.amount),
                            currencyCode: order.originalTotalPrice.currencyCode.rawValue,
                            processedAt: order.processedAt
                        )
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
        
    }
}
