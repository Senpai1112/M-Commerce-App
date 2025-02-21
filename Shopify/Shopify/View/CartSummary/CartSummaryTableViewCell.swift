//
//  CartSummaryTableViewCell.swift
//  Shopify
//
//  Created by Yasser Yasser on 20/02/2025.
//

import UIKit

class CartSummaryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var productDetails: UILabel!
    @IBOutlet weak var productQuantaty: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
    }
    
    func initUI(){
        productPrice.textColor = .systemRed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
