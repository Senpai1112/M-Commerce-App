//
//  CashOnDeliveryViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 18/02/2025.
//

import UIKit

class CashOnDeliveryViewController: UIViewController {

    @IBOutlet weak var subTotal: UILabel!
    
    @IBOutlet weak var shippingFees: UILabel!
    
    
    @IBOutlet weak var grandTotal: UILabel!
    
    @IBOutlet weak var placeOrder: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var address1Label: UILabel!
    
    @IBOutlet weak var address2Label: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    var customerDetails = CustomerDetails()
    var address = Addresses()
    var cartDetails = CartResponse()

    let orderViewModel = OrderViewModel()
    let cartViewModel = CartViewModel()
    
    var newPrice = ""
    
/*
    var customerAccessToken: String {
        return UserDefaults.standard.string(forKey: "customerAccessToken") ?? ""
    }

    var cartId: String {
        return UserDefaults.standard.string(forKey: "cartId") ?? ""
    }
*/
    var customerAccessToken  = "fc1bea2489ae90f294f2c8795e0dd7ff"
    var cartId : String = "gid://shopify/Cart/Z2NwLWV1cm9wZS13ZXN0MTowMUpNRVg5SjkzQk1DTjExNjNLUUNGTVdRWg?key=c4a1a467f54521f9a8e6ccaf6f3a584b"
    
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
        subTotal.text = "\(newPrice) \(address.countryCode ?? "")"
        shippingFees.text = "30.0 \(address.countryCode ?? "")"
        let floatGrandTotal = (subTotal.text! as NSString).floatValue + 30.0
        grandTotal.text = "\(floatGrandTotal) \(address.countryCode ?? "")"
        
        nameLabel.text = customerDetails.firstName
        countryLabel.text = address.country
        address1Label.text = address.address1
        address2Label.text = address.address2
        cityLabel.text = address.city
        phoneLabel.text = address.phone
    }
    
    @IBAction func placeOrder(_ sender: UIButton) {
        var ids = [String]()
        if let cart = cartDetails.cart{
            for item in cart {
                let variantId = extractVariantID(from: item.merchandise!.id)
                let intVariantId = variantId?.codingKey.intValue
                let address = Address(address1: address.address1!, phone: address.phone!, city: address.city!, country: address.country!)
                let newPriceDouble = Double(newPrice)
                orderViewModel.createOrder(first_name: customerDetails.firstName!, last_name: customerDetails.lastName!, email: customerDetails.email!, variant_id: intVariantId! , quantity: item.quantity!, billing_address: address, shipping_address: address, transaction_amount: newPriceDouble!)
                ids.append(item.id!)
            }
        }
        cartViewModel.deleteLineInCart(cartID: cartId, lineID: ids)
        let alert = UIAlertController(title: "Order Placed Successfully", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self]_ in
            if let navigationController = self?.navigationController {
                let viewControllers = navigationController.viewControllers
                if viewControllers.count >= 5 {
                    navigationController.popToViewController(viewControllers[viewControllers.count - 5], animated: true)
                }
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
