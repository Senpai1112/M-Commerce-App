//
//  SettingsTableViewCell.swift
//  Shopify
//
//  Created by Yasser Yasser on 14/02/2025.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var staticImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
