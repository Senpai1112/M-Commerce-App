//
//  ProductCell.swift
//  Shopify
//
//  Created by Mai Atef  on 13/02/2025.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var PriceLabel: UILabel!

    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var ProductBorder: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ProductBorder.layer.cornerRadius = 10
        ProductBorder.layer.shadowColor = UIColor.black.cgColor
        ProductBorder.layer.shadowOffset = CGSize(width: 0, height: 2)
        ProductBorder.layer.shadowRadius = 4
        ProductBorder.layer.shadowOpacity = 0.2
        
        ProductBorder.layer.borderColor = UIColor.lightGray.cgColor
        ProductBorder.layer.borderWidth = 0.5
        PriceLabel.textAlignment = .center
        PriceLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        productTitle.font = UIFont.systemFont(ofSize: 12, weight: .medium)

                }

    
}
