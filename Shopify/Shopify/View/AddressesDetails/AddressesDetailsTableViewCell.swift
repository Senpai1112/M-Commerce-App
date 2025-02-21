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
    
    @IBOutlet weak var addressDetailsViewCell: UIView!
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        // Initialization code
    }

    func initUI(){
        addressDetailsViewCell.layer.cornerRadius = 10
        addressDetailsViewCell.layer.shadowColor = UIColor.black.cgColor
        addressDetailsViewCell.layer.shadowOffset = CGSize(width: 0, height: 2)
        addressDetailsViewCell.layer.shadowRadius = 4
        addressDetailsViewCell.layer.shadowOpacity = 0.2
        
        addressDetailsViewCell.layer.borderColor = UIColor.lightGray.cgColor
        addressDetailsViewCell.layer.borderWidth = 5

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
