//
//  AddressesDetailsTableViewCell.swift
//  Shopify
//
//  Created by Yasser Yasser on 15/02/2025.
//

import UIKit

class AddressesDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var cityAndAdressDetails: UILabel!
    
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
