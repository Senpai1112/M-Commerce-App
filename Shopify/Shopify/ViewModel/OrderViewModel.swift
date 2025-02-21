//
//  OrderViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 20/02/2025.
//
import Foundation

class OrderViewModel: ObservableObject {
    var isLoading: Bool = false {
        didSet {
            print("Loading state changed: \(isLoading)")
        }
    }

    var errorMessage: String? = nil {
        didSet {
            if let error = errorMessage {
                print("Error occurred: \(error)")
            }
        }
    }

    func createOrder(
        first_name: String,
        last_name: String,
        email: String,
        variant_id: Int,
        quantity: Int,
        billing_address: Address,
        shipping_address: Address,
        transaction_amount: Double
    ) {
        isLoading = true
        errorMessage = nil

        let order = Order(
            line_items: [LineItem(variant_id: variant_id, quantity: quantity)],
            customer: CustomerModel(first_name: first_name, last_name: last_name, email: email),
            billing_address: billing_address,
            shipping_address: shipping_address,
            email: email,
            transactions: [Transaction(kind: "authorization", status: "success", amount: transaction_amount)],
            financial_status: "partially_paid"
        )

        let orderRequest = OrderRequest(order: order)

        do {
            let jsonData = try JSONEncoder().encode(orderRequest)
            RestApiSendOrder.shared.sendOrderToShopify(jsonData: jsonData,compeltion: {string in
                self.isLoading = false
                self.errorMessage = string
            })
        } catch {
            isLoading = false
            errorMessage = "Failed to encode JSON"
            print("Encoding error: \(error)")
        }
    }
}
