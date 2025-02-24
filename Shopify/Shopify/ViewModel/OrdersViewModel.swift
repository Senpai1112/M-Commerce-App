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
    func mapCost(amount: String?, currencyCode: String?) -> Double? {
            guard let amount = amount else { return nil }
            let doubleCost = (Double(amount) ?? 0.0) * UserDefaults.standard.double(forKey: "currencyValue")
            let formattedPrice = (doubleCost * 100).rounded() / 100
            return formattedPrice
        }
    
    func getOrdersFromModel(token: String) {
        ApolloProductsNetwokService.shared.fetchCustomerOrders(token: token) { [weak self] result in
            switch result {
            case .success(let data):
                if let ordersEdges = data.data?.customer?.orders.edges {
                    
                    self?.finalResult = ordersEdges.map { edge in
                        let order = edge.node
                        return Orders(
                            price: self?.mapCost(amount: order.originalTotalPrice.amount, currencyCode: order.originalTotalPrice.currencyCode.rawValue) ?? 0.0,
                            currencyCode: UserDefaults.standard.string(forKey: "currencyCode") ?? "USD",
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
