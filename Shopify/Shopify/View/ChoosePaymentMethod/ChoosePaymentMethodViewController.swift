//
//  ChoosePaymentMethodViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 17/02/2025.
//

import UIKit
import PassKit

class ChoosePaymentMethodViewController: UIViewController {

    @IBOutlet weak var continueToPayment: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var address = Addresses()
    var selectedIndex: IndexPath?
    var headersForSections : [String] = ["Online Payment","More Payment Options"]
    var titlesForRow : [String] = [" Apple Pay","Cash On Delivery (COD)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(address.city!)
        initNib()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Payment Options"
    }
    
    @IBAction func continueToPayment(_ sender: UIButton) {
        if selectedIndex == nil{
            let alert = UIAlertController(title: "Please Choose Payment Method", message:"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive) { _ in})
            self.present(alert, animated: true)
        }
        else{
            if selectedIndex?.section == 0{
                
            }
        }
    }
    func initNib(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ChoosePaymentMethodTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ChoosePaymentMethodTableViewCell")
    }
    func initUI(){
        continueToPayment.layer.cornerRadius = continueToPayment.frame.height / 2
        continueToPayment.layer.cornerCurve = .continuous
        continueToPayment.clipsToBounds = true
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
extension ChoosePaymentMethodViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return headersForSections[section]
        default:
            return headersForSections[section]
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoosePaymentMethodTableViewCell", for: indexPath) as! ChoosePaymentMethodTableViewCell
        configureCell(cell, at: indexPath)
        return cell
    }
    
    
    func configureCell(_ cell: ChoosePaymentMethodTableViewCell, at indexPath: IndexPath) {
        
        cell.selectionStyle = .none
        
        cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        cell.checkButton.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
        
        cell.paymentMethodLabel.text = titlesForRow[indexPath.section]
        
        if selectedIndex == indexPath {
            cell.checkButton.isSelected = true
        } else {
            cell.checkButton.isSelected = false
        }
        
        cell.backgroundColor = .systemGray6
        cell.layer.borderColor = UIColor.systemBackground.cgColor
        cell.layer.borderWidth = 10
        cell.clipsToBounds = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        tableView.reloadData()
    }
    
    func startApplePay(address : Addresses , customer : Customer , price : Price) {
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

}

extension ChoosePaymentMethodViewController: PKPaymentAuthorizationViewControllerDelegate {
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
