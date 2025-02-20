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
    
    @IBOutlet weak var settingsCellLayer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func initUI(){
        detailsLabel.textColor = UIColor.purple
        settingsCellLayer.layer.cornerRadius = 10
        settingsCellLayer.layer.shadowColor = UIColor.black.cgColor
        settingsCellLayer.layer.shadowOffset = CGSize(width: 0, height: 2)
        settingsCellLayer.layer.shadowRadius = 4
        settingsCellLayer.layer.shadowOpacity = 0.2
        
        settingsCellLayer.layer.borderColor = UIColor.lightGray.cgColor
        settingsCellLayer.layer.borderWidth = 5
    }
    
}
