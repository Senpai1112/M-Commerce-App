//
//  OrderViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 24/02/2025.
//

import UIKit

class OrderDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var order: Orders!

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
   
    @IBOutlet weak var itemsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Order Details"
        initNib()
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        email.text = order.email
        orderPriceLabel.text = " \(order.price ?? 0) \(order.currencyCode ?? "")"
        orderDateLabel.text =  order.processedAt?.formattedDate() ?? " "
       
    }
    
    
    
    func initNib(){
        let nib = UINib(nibName: "OrderInfoCell", bundle: nil)
        self.itemsTableView.register(nib, forCellReuseIdentifier: "OrderInfoCell")
       
            
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.lineItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderInfoCell", for: indexPath) as! OrderInfoCell
        
        let item = order.lineItems[indexPath.row]
        cell.quantityLable.text = "quantity : \(item.quantity ?? 0)"
        cell.orderTitle.text = item.title ?? ""
        cell.orderPrice.text = "price : \(item.price ?? 0) \(item.currencyCode ?? "")"
        cell.subTitle.text = item.variant
        if let imgURL = URL(string: item.image ?? "") {
            cell.OrderImage.kf.setImage(with: imgURL, placeholder: UIImage(named: "1"))
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
}
