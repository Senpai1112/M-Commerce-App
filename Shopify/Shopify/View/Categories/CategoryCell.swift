//
//  CategoryCell.swift
//  Shopify
//
//  Created by Mai Atef  on 17/02/2025.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var PriceLabel: UILabel!

    @IBOutlet weak var vendorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var ProductBorder: UIView!
    
    @IBOutlet weak var favButton: UIButton!
    
    var addToFavList: (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        ProductBorder.layer.cornerRadius = 10
        ProductBorder.layer.shadowColor = UIColor.black.cgColor
        ProductBorder.layer.shadowOffset = CGSize(width: 0, height: 2)
        ProductBorder.layer.shadowRadius = 4
        ProductBorder.layer.shadowOpacity = 0.2
        
        ProductBorder.layer.borderColor = UIColor.lightGray.cgColor
        ProductBorder.layer.borderWidth = 0.5
        vendorLabel.textAlignment = .center
        PriceLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        currencyCodeLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        vendorLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)

                }
    
    @IBAction func addToWishList(_ sender: UIButton) {
        addToFavList?()
    }
}
