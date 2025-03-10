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
    
    let sendEmailViewModel = SendEmailViewModel()
    
    var newPrice = ""
    
    var selectedDiscountCopon = ""
    
    @IBOutlet weak var continueToPayment: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var customerAccessToken: String {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    var cartId : String {
        return UserDefaults.standard.string(forKey: "cartID") ?? ""
    }
    
    //var price = Price(amount: "1234.50", currencyCode: "EGP")
    var customerDetails = CustomerDetails()
    var address = Addresses()
    var cartDetails = CartResponse()
    var selectedIndex: IndexPath?
    var headersForSections : [String] = ["Online Payment","More Payment Options"]
    var titlesForRow : [String] = [" Apple Pay","Cash On Delivery (COD)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                vc.selectedDiscountCopon = selectedDiscountCopon
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
        return headersForSections[section]
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
        paymentRequest.countryCode = address.countryCode ?? "EG"
        paymentRequest.currencyCode = cart.totalCost?.totalAmount?.currencyCode ?? "EGP"
        
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
        let cartTotalPrice = Double(newPrice) ?? 0.0
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(value: cartTotalPrice))
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
        var paymentSuccess = false
        let paymentToken = payment.token
        print("Payment Token: \(paymentToken)")
        
        let status = PKPaymentAuthorizationStatus.success
        let result = PKPaymentAuthorizationResult(status: status, errors: nil)
        if result.status == .success {
            print("Payment succeeded")
            paymentSuccess = true
            var lineItems = [LineItem]()
            var ids = [String]()
            guard let items = cartDetails.cart else { return }
            guard let address1 = address.address1, let phone = address.phone, let city = address.city, let country = address.country else {
                print("Address details are missing")
                return
            }
            
            let cartTotalPrice = Double(newPrice) ?? 0.0

            let address = Address(address1: address1, phone: phone, city: city, country: country)
            
            for item in items {
                guard let merchandise = item.merchandise else { return }
                guard let quantaty = item.quantity else {return}
                let variantId = extractVariantID(from: merchandise.id)
                let intVariantId = variantId?.codingKey.intValue
                guard let intVariantId = intVariantId else {return}
                
                guard let id = item.id else { return }
                ids.append(id)
                lineItems.append(LineItem(variant_id: intVariantId, quantity: quantaty))
            }
            orderViewModel.createOrder(firstName: customerDetails.firstName!, lastName: customerDetails.lastName!, email: customerDetails.email!,lineItems : lineItems, billingAddress: address, shippingAddress: address, transactionAmount: cartTotalPrice, discountCodes: [CoponCodes(code: UserDefaults.standard.string(forKey: "selectedDiscountCopon") ?? "Nothing", amount: "50", type: "percentage")])
            cartViewModel.deleteLineInCart(cartID: cartId, lineID: ids)
            orderViewModel.bindLoadingToCashOnDelivery = {[weak self] in
                if self?.orderViewModel.isLoading == true{
                    print("Still loading")
                }else{
                    self?.sendEmailViewModel.sendMailForCustomer(customerAccessToken: self?.customerAccessToken ?? "", customerDetails: self?.customerDetails ?? CustomerDetails(), address: self?.address ?? Addresses() , newPrice: self?.newPrice ?? "0.0")
                }
            }
            
            sendEmailViewModel.bindMailResult = {[weak self] in
                print(self?.sendEmailViewModel.mailResult ?? "nothing here")
            }
            UserDefaults.standard.set("", forKey: selectedDiscountCopon)
        } else {
            print("Payment failed with status: \(result.status.rawValue)")
        }
        completion(result)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            controller.dismiss(animated: true) {
                print("Apple Pay dismissed")
                
                // Navigate back only if payment was successful
                if paymentSuccess, let navigationController = self.navigationController {
                    let viewControllers = navigationController.viewControllers
                    let targetIndex = max(0, viewControllers.count - 5)
                    navigationController.popToViewController(viewControllers[targetIndex], animated: true)
                }
            }
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion:nil)
        print("payment finished")
    }
}
