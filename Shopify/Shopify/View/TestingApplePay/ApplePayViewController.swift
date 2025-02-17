//
//  ApplePayViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 16/02/2025.
//

import UIKit
import PassKit

class ApplePayViewController: UIViewController {
    
    var emailAddress : String?
    var country : String?
    var phoneNumber : String?
    var address1 : String?
    var address2 : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let paymentButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        paymentButton.addTarget(self, action: #selector(startApplePay), for: .touchUpInside)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paymentButton)
        
        // Constraints for the button
        NSLayoutConstraint.activate([
            paymentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            paymentButton.widthAnchor.constraint(equalToConstant: 200),
            paymentButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func startApplePay() {
        let paymentRequest = PKPaymentRequest()
        
        // Configure your Merchant ID merchant.2jd4vk6g4v2prs6z
        paymentRequest.merchantIdentifier = "merchant.2jd4vk6g4v2prs6z"
        paymentRequest.supportedNetworks = [.visa, .masterCard, .amex, .discover]
        paymentRequest.merchantCapabilities = .threeDSecure
        paymentRequest.countryCode = "US" // Your country code
        paymentRequest.currencyCode = "USD" // Your currency code
        
        // Required fields
        paymentRequest.requiredShippingContactFields = [.name, .postalAddress, .phoneNumber, .emailAddress]
        
        // Payment Summary Items
        let item1 = PKPaymentSummaryItem(label: "Product 1", amount: NSDecimalNumber(string: "19.99"))
        let item2 = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(string: "1.99"))
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "21.98"))
        
        paymentRequest.paymentSummaryItems = [item1, item2, total]
        
        if #available(iOS 11.0, *) {
            let shippingContact = PKContact()
            
            // Set up the name (optional)
            var nameComponents = PersonNameComponents()
            nameComponents.givenName = "John"
            nameComponents.familyName = "Appleseed"
            shippingContact.name = nameComponents
            
            // Set up the postal address
            let postalAddress = CNMutablePostalAddress()
            postalAddress.street = "1 Infinite Loop"
            postalAddress.city = "Cupertino"
            postalAddress.state = "CA"
            postalAddress.postalCode = "95014"
            postalAddress.country = "United States"
            shippingContact.postalAddress = postalAddress
            // Optionally, add phone number and email (if needed)
            // shippingContact.phoneNumber = CNPhoneNumber(stringValue: "123-456-7890")
            shippingContact.emailAddress = "john.appleseed@example.com"
            
            paymentRequest.shippingContact = shippingContact
        }
        
        // Present Apple Pay sheet
        if let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            paymentVC.delegate = self
            present(paymentVC, animated: true, completion: nil)
        } else {
            print("Unable to present Apple Pay authorization.")
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ApplePayViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                            didAuthorizePayment payment: PKPayment,
                                            handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Send payment token to your server or payment processor
        let paymentToken = payment.token
        print("Payment Token: \(paymentToken)")
        
        // Handle success or failure
        let status = PKPaymentAuthorizationStatus.success
        let result = PKPaymentAuthorizationResult(status: status, errors: nil)
        completion(result)
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
