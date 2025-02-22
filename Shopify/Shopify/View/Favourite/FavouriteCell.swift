//
//  FavouriteCell.swift
//  Shopify
//
//  Created by Mai Atef  on 21/02/2025.
//

import UIKit

class FavouriteCell: UITableViewCell {

    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var favPrice: UILabel!
    @IBOutlet weak var favTitle: UILabel!
    @IBOutlet weak var favBorder: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favImage.contentMode = .scaleAspectFill
           favImage.clipsToBounds = true
        favBorder.layer.cornerRadius = 10
        favBorder.layer.shadowColor = UIColor.black.cgColor
        favBorder.layer.shadowOffset = CGSize(width: 0, height: 2)
        favBorder.layer.shadowRadius = 4
        favBorder.layer.shadowOpacity = 0.2
        
        favBorder.layer.borderColor = UIColor.lightGray.cgColor
        favBorder.layer.borderWidth = 0.5
        favPrice.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        favTitle.numberOfLines = 2
        favTitle.lineBreakMode = .byWordWrapping
        favTitle.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    }

    
    
}
