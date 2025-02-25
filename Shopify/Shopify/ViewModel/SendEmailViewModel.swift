//
//  SendEmailViewModel.swift
//  Shopify
//
//  Created by Yasser Yasser on 25/02/2025.
//

import Foundation
import MyApi
import SwiftSMTP
import Apollo


class SendEmailViewModel{
    var bindMailResult : (()->()) = {}
    
    var mailResult : String = ""{
        didSet{
            bindMailResult()
        }
    }
    
    func sendMailForCustomer(customerAccessToken : String,customerDetails : CustomerDetails , address : Addresses , newPrice : String){
        ApolloProductsNetwokService.fetchCustomerOrders(token: customerAccessToken, completion: {[weak self] graphQlResult in
            switch graphQlResult {
            case .success(let result):
                guard let orders = result.data?.customer?.orders.edges.last?.node else {
                    print("Error fetching Orders")
                    return
                }
                guard let address1 = address.address1, let phone = address.phone, let city = address.city, let country = address.country, let address2 = address.address2 else {
                    print("Address details are missing")
                    return
                }
                let customerAddress = "\(country) \n\(city) \n\(address1) \n\(address2) \n\(phone) \n"
                guard let customerEmail = customerDetails.email else { return }
                guard let customerName = customerDetails.firstName else { return }
                var items = orders.lineItems.edges.map { "\($0.node.title) \($0.node.quantity) \($0.node.originalTotalPrice.amount) \($0.node.originalTotalPrice.currencyCode.rawValue)" }.joined(separator: " ,\n ")
                items += "\n total price of \(newPrice) \(orders.originalTotalPrice.currencyCode.rawValue)"
                
                self?.sendEmailViaBrevoSMTP(
                    toEmail: customerEmail,
                    subject: "Your Order Details on Cartique",
                    body: "Hello \(customerName),\n your order id is \(orders.id)\n your order includes:\n \(items). \n \(customerAddress)")
            case .failure(let error):
                self?.mailResult = error.localizedDescription
            }
        })
    }
    
    private func sendEmailViaBrevoSMTP(toEmail: String, subject: String, body: String) {
        // Configure SMTP server
        let smtp = SMTP(
            hostname: "smtp-relay.brevo.com",
            email:"86a103003@smtp-brevo.com",
            password: "75AspDYajJgqbNty",
            port: 587,
            tlsMode: .ignoreTLS
        )
        
        let sender = Mail.User(name: "Cartique", email: "youssabyasser@gmail.com")
        let recipient = Mail.User(email: toEmail)
        
        let mail = Mail(from: sender, to: [recipient], subject: subject, text: body)
        
        smtp.send(mail) {[weak self] error in
            if let error = error {
                print()
                self?.mailResult = "❌ Email sending failed: \(error.localizedDescription)"
            } else {
                self?.mailResult = "✅ Email sent successfully"
            }
        }
    }
}
