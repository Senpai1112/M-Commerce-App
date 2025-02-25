//
//  OrderViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 20/02/2025.
//
import Foundation

class OrderViewModel: ObservableObject {
    var bindLoadingToCashOnDelivery :(()->()) = {}
    var isLoading: Bool = false {
        didSet {
            print("Loading state changed: \(isLoading)")
            bindLoadingToCashOnDelivery()
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
        firstName: String,
        lastName: String,
        email: String,
        lineItems : [LineItem],
        billingAddress: Address,
        shippingAddress: Address,
        transactionAmount: Double
    ) {
        isLoading = true
        errorMessage = nil

        let order = Order(
            line_items: lineItems,
            customer: CustomerModel(first_name: firstName, last_name: lastName, email: email),
            billing_address: billingAddress,
            shipping_address: shippingAddress,
            email: email,
            transactions: [Transaction(kind: "authorization", status: "success", amount: transactionAmount)],
            financial_status: "paid"
        )

        let orderRequest = OrderRequest(order: order)

        do {
            let jsonData = try JSONEncoder().encode(orderRequest)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("Encoded JSON: \(jsonString)")
                } else {
                    print("Failed to convert JSON data to string")
                }
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
