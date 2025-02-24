//
//  OrderViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 24/02/2025.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var order: Orders!

    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "orderInfoCell")
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self

        orderPriceLabel.text = "Price: \(order.price ?? 0) \(order.currencyCode ?? "")"
        orderDateLabel.text = "Created At: \(order.processedAt ?? "")"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.lineItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderInfoCell", for: indexPath)
        let item = order.lineItems[indexPath.row]

        cell.textLabel?.text = item.title ?? ""
        if let imgURL = URL(string: item.image ?? "") {
            cell.imageView?.kf.setImage(with: imgURL, placeholder: UIImage(named: "1"))
            
        }
        return cell
    }
}
