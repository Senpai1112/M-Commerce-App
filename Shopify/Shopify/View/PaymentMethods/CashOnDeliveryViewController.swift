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
    
    var customerDetails : CustomerDetails?
    var address : Addresses?
    var cartDetails : CartResponse?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        subTotal.text = "\(cartDetails?.totalCost?.totalAmount?.amount ?? "") \(address?.countryCode ?? "")"
        shippingFees.text = "30.0 \(address?.countryCode ?? "")"
        let floatGrandTotal = (subTotal.text! as NSString).floatValue + 30.0
        grandTotal.text = "\(floatGrandTotal)"
    }
    
    @IBAction func placeOrder(_ sender: UIButton) {
        
    }
    func initUI(){
        placeOrder.layer.cornerRadius = placeOrder.frame.height / 2
        placeOrder.layer.cornerCurve = .continuous
        placeOrder.clipsToBounds = true
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
