//
//  CashOnDeliveryViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 18/02/2025.
//

import UIKit
import Firebase


class CashOnDeliveryViewController: UIViewController {
    
    @IBOutlet weak var grandTotal: UILabel!
        
    
    @IBOutlet weak var placeOrder: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var address1Label: UILabel!
    
    @IBOutlet weak var address2Label: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var currencyCodeGrandTotal: UILabel!
    
    var selectedDiscountCopon = ""
    var customerDetails = CustomerDetails()
    var address = Addresses()
    var cartDetails = CartResponse()
    
    let orderViewModel = OrderViewModel()
    let cartViewModel = CartViewModel()
    let sendEmailViewModel = SendEmailViewModel()
    
    var newPrice = ""
    
    var customerAccessToken: String {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    var cartId : String {
        return UserDefaults.standard.string(forKey: "cartID") ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    func updateUI(){
        grandTotal.text = "\(newPrice)"
        nameLabel.text = customerDetails.firstName
        countryLabel.text = address.country
        address1Label.text = address.address1
        address2Label.text = address.address2
        cityLabel.text = address.city
        phoneLabel.text = address.phone
        currencyCodeGrandTotal.text = cartDetails.totalCost?.totalAmount?.currencyCode ?? "EGP"
    }
    
    @IBAction func placeOrder(_ sender: UIButton) {
        var lineItems = [LineItem]()
        var ids = [String]()
        guard let items = cartDetails.cart else { return }
        guard let address1 = address.address1, let phone = address.phone, let city = address.city, let country = address.country else {
            print("Address details are missing")
            return
        }
        let newPriceDouble = Double(newPrice)
        let address = Address(address1: address1, phone: phone, city: city, country: country)
        
        for item in items {
            guard let merchandise = item.merchandise else { return }
            guard let quantaty = item.quantity else {return}
            let variantId = extractVariantID(from: merchandise.id)
            let intVariantId = variantId?.codingKey.intValue
            guard let intVariantId = intVariantId else {return}
            //variants.append(intVariantId)
            
            guard let id = item.id else { return }
            ids.append(id)
            lineItems.append(LineItem(variant_id: intVariantId, quantity: quantaty))
        }
        orderViewModel.createOrder(firstName: customerDetails.firstName!, lastName: customerDetails.lastName!, email: customerDetails.email!,lineItems : lineItems, billingAddress: address, shippingAddress: address, transactionAmount: newPriceDouble!, discountCodes: [CoponCodes(code: UserDefaults.standard.string(forKey: "selectedDiscountCopon") ?? "", amount: "50", type: "percentage")])
        cartViewModel.deleteLineInCart(cartID: cartId, lineID: ids)
        sendEmailViewModel.bindMailResult = {[weak self] in
            print(self?.sendEmailViewModel.mailResult ?? "nothing here")
        }
        orderViewModel.bindLoadingToCashOnDelivery = {[weak self] in
            if self?.orderViewModel.isLoading == true{
                print("Still loading")
            }else{
                self?.sendEmailViewModel.sendMailForCustomer(customerAccessToken: self?.customerAccessToken ?? "", customerDetails: self?.customerDetails ?? CustomerDetails(), address: self?.address ?? Addresses() ,newPrice: self?.grandTotal.text ?? "0.0")
            }
        }
        UserDefaults.standard.set("", forKey: selectedDiscountCopon)
        
        let alert = UIAlertController(title: "Order Placed Successfully", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self]_ in
            if let navigationController = self?.navigationController {
                let viewControllers = navigationController.viewControllers
                let targetIndex = max(0, viewControllers.count - 6) // Go back 4 times
                navigationController.popToViewController(viewControllers[targetIndex], animated: true)
            }
        })
        self.present(alert, animated: true)
    }
    func initUI(){
        placeOrder.layer.cornerRadius = placeOrder.frame.height / 2
        placeOrder.layer.cornerCurve = .continuous
        placeOrder.tintColor = UIColor.purple
        placeOrder.clipsToBounds = true
    }
    
    func extractVariantID(from gid: String) -> String? {
        let components = gid.components(separatedBy: "/")
        return components.last
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
