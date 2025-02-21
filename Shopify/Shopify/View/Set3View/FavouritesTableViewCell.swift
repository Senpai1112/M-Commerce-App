//
//  FavouritesTableViewCell.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 20/02/2025.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {

    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(photo: String,name:String,price: String){
        productImage.kf.setImage(with: URL(string: photo))
        productName.text = name
        productPrice.text = price

       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
