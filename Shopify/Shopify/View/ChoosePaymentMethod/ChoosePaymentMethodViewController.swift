//
//  ChoosePaymentMethodViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 17/02/2025.
//

import UIKit
import PassKit

class ChoosePaymentMethodViewController: UIViewController {
    
    let customerDetailsViewModel = CustomerDetailsViewModel()
    let cartViewModel = CartViewModel()
    
    let orderViewModel = OrderViewModel()
    
    var newPrice = ""
    
    @IBOutlet weak var continueToPayment: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var customerAccessToken  = "fc1bea2489ae90f294f2c8795e0dd7ff"
    var cartId : String = "gid://shopify/Cart/Z2NwLWV1cm9wZS13ZXN0MTowMUpNRVg5SjkzQk1DTjExNjNLUUNGTVdRWg?key=c4a1a467f54521f9a8e6ccaf6f3a584b"
    
    //var price = Price(amount: "1234.50", currencyCode: "EGP")
    var customerDetails = CustomerDetails()
    var address = Addresses()
    var cartDetails = CartResponse()
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
        self.customerDetailsViewModel.bindResultToPaymentMethod = {[weak self] in
            DispatchQueue.main.async{
                self?.customerDetails = (self?.customerDetailsViewModel.customerDetails)!
            }
        }
        customerDetailsViewModel.getCustomerDetails(customerAccessToken: customerAccessToken)
        self.cartViewModel.bindResultToShoppingCartTableViewController = {[weak self] in
            DispatchQueue.main.async{
                self?.cartDetails = (self?.cartViewModel.cartResult)!
            }
        }
        cartViewModel.getCartFromModel(cartID: cartId)
    }
    
    @IBAction func continueToPayment(_ sender: UIButton) {
        if selectedIndex == nil{
            let alert = UIAlertController(title: "Please Choose Payment Method", message:"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive) { _ in})
            self.present(alert, animated: true)
        }
        else{
            if selectedIndex?.section == 0{
                startApplePay(address: address, customer: customerDetails, cart : cartDetails)
            }else{
                let storyBoard = UIStoryboard(name: "Set2", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "CashOnDeliveryViewController") as! CashOnDeliveryViewController
                vc.customerDetails = customerDetailsViewModel.customerDetails
                vc.address = address
                vc.cartDetails = cartViewModel.cartResult
                vc.newPrice = newPrice
                self.navigationController?.pushViewController(vc, animated: true)
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
        continueToPayment.tintColor = UIColor.purple

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
    
    func startApplePay(address : Addresses , customer : CustomerDetails , cart : CartResponse) {
        let paymentRequest = PKPaymentRequest()
        
        // Configure your Merchant ID merchant.2jd4vk6g4v2prs6z
        
        paymentRequest.merchantIdentifier = "merchant.2jd4vk6g4v2prs6z"
        paymentRequest.supportedNetworks = [.visa, .masterCard, .amex, .discover]
        paymentRequest.merchantCapabilities = .threeDSecure
        paymentRequest.countryCode = address.countryCode!
        paymentRequest.currencyCode = "USD"
        
        // Required fields
        paymentRequest.requiredShippingContactFields = [.name, .postalAddress, .phoneNumber, .emailAddress]
        
        // Payment Summary Items
        var items = [PKPaymentSummaryItem]()
        if let cart = cart.cart{
            for item in cart {
                let tempItems = PKPaymentSummaryItem(label: (item.merchandise?.title)!, amount: NSDecimalNumber(string: item.cost?.totalAmount?.amount))
                items.append(tempItems)
            }
        }
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: newPrice))
        items.append(total)
        paymentRequest.paymentSummaryItems = items
        
        let shippingContact = PKContact()
        
        var nameComponents = PersonNameComponents()
        nameComponents.givenName = customer.firstName
        nameComponents.familyName = customer.lastName
        shippingContact.name = nameComponents
        
        let postalAddress = CNMutablePostalAddress()
        postalAddress.street = address.address2!
        postalAddress.city = address.city!
        postalAddress.state = address.country!
        postalAddress.postalCode = "95014"
        postalAddress.country = address.country!
        shippingContact.postalAddress = postalAddress
        
        
        shippingContact.emailAddress = customer.email
        
        paymentRequest.shippingContact = shippingContact
        
        if let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
            paymentVC.delegate = self
            present(paymentVC, animated: true, completion: nil)
        } else {
            print("Unable to present Apple Pay authorization.")
        }
    }
    
    func extractVariantID(from gid: String) -> String? {
        let components = gid.components(separatedBy: "/")
        return components.last
    }
}

extension ChoosePaymentMethodViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                            didAuthorizePayment payment: PKPayment,
                                            handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        let paymentToken = payment.token
        print("Payment Token: \(paymentToken)")
        
        let status = PKPaymentAuthorizationStatus.success
        let result = PKPaymentAuthorizationResult(status: status, errors: nil)
        if result.status == .success {
            print("Payment succeeded")
            var ids = [String]()
            for item in cartDetails.cart! {
                let variantId = extractVariantID(from: item.merchandise!.id)
                let intVariantId = variantId?.codingKey.intValue
                let address = Address(address1: address.address1!, phone: address.phone!, city: address.city!, country: address.country!)
                let newPriceDouble = Double(newPrice)
                orderViewModel.createOrder(first_name: customerDetails.firstName!, last_name: customerDetails.lastName!, email: customerDetails.email!, variant_id: intVariantId! , quantity: item.quantity!, billing_address: address, shipping_address: address, transaction_amount: newPriceDouble!)
                ids.append(item.id!)
            }
            cartViewModel.deleteLineInCart(cartID: cartId, lineID: ids)
        } else {
            print("Payment failed with status: \(result.status.rawValue)")
        }
        completion(result)
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: {
            if let navigationController = self.navigationController {
                let viewControllers = navigationController.viewControllers
                if viewControllers.count >= 5 {
                    navigationController.popToViewController(viewControllers[viewControllers.count - 5], animated: true)
                }
            }
        })
        print("payment finished")
    }
}
