//
//  OrderCell.swift
//  Shopify
//
//  Created by Mai Atef  on 20/02/2025.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var orderDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        
        orderView.layer.cornerRadius = 10
        orderView.layer.shadowColor = UIColor.black.cgColor
        orderView.layer.shadowRadius = 5
        orderView.layer.shadowOpacity = 0.2
        orderView.layer.shadowOffset = CGSize(width: 0, height: 2)

        orderView.layer.borderColor = UIColor.lightGray.cgColor
        orderView.layer.borderWidth = 0.5
    }

   
        // Configure the view for the selected state
    
}
