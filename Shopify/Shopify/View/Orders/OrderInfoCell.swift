//
//  OrderInfoCell.swift
//  Shopify
//
//  Created by Mai Atef  on 24/02/2025.
//

import UIKit

class OrderInfoCell: UITableViewCell {

    @IBOutlet weak var quantityLable: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var OrderImage: UIImageView!
        @IBOutlet weak var orderPrice: UILabel!
        @IBOutlet weak var orderTitle: UILabel!
        @IBOutlet weak var orderBorder: UIView!
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            OrderImage.contentMode = .scaleAspectFill
            OrderImage.clipsToBounds = true
            orderBorder.layer.cornerRadius = 10
            orderBorder.layer.shadowColor = UIColor.black.cgColor
            orderBorder.layer.shadowOffset = CGSize(width: 0, height: 2)
            orderBorder.layer.shadowRadius = 4
            orderBorder.layer.shadowOpacity = 0.2
            
            orderBorder.layer.borderColor = UIColor.lightGray.cgColor
            orderBorder.layer.borderWidth = 0.5
            orderPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            orderTitle.numberOfLines = 2
            orderTitle.lineBreakMode = .byWordWrapping
            orderTitle.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        }

        
        
    }
