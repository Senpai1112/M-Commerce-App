////
////  OrderViewModel.swift
////  Shopify
////
////  Created by Yasser Yasser on 20/02/2025.
////
//
//import Foundation
//
//class OrderViewModel{
//    
//    var bindOrder : (()->()) = {}
//    var OrderResult = OrderRequest() {
//        didSet{
//            bindOrder()
//        }
//    }
//    
//    func createOrderJSON(
//        firstName: String,
//        lastName: String,
//        email: String,
//        variantID: Int,
//        quantity: Int,
//        billingAddress: Address,
//        shippingAddress: Address,
//        transactionAmount: Double
//        ) {
//        let order = Order(
//            lineItems: [LineItem(variantID: variantID, quantity: quantity)],
//            customer: CustomerModelJson(firstName: firstName, lastName: lastName, email: email),
//            billingAddress: billingAddress,
//            shippingAddress: shippingAddress,
//            email: email,
//            transactions: [Transaction(kind: "authorization", status: "success", amount: transactionAmount)],
//            financialStatus: "partially_paid"
//        )
//        
//        let orderRequest = OrderRequest(order: order)
//
//        do {
//            let jsonData = try JSONEncoder().encode(orderRequest)
//        } catch {
//            print("Error encoding JSON: \(error)")
//        }
//    }
//}
