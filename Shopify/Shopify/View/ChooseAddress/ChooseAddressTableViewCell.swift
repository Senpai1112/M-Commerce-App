//
//  ChooseAddressTableViewCell.swift
//  Shopify
//
//  Created by Yasser Yasser on 17/02/2025.
//

import UIKit

class ChooseAddressTableViewCell: UITableViewCell {
    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initUI(){
        checkButton.layer.cornerRadius = 15
        checkButton.clipsToBounds = true
    }
    
}
