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
    
    @IBOutlet weak var discount: UILabel!
    
    @IBOutlet weak var grandTotal: UILabel!
    @IBOutlet weak var copon: UITextField!
    
    @IBOutlet weak var placeOrder: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func placeOrder(_ sender: UIButton) {
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
