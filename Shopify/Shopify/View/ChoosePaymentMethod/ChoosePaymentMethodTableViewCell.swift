//
//  ChoosePaymentMethodTableViewCell.swift
//  Shopify
//
//  Created by Yasser Yasser on 17/02/2025.
//

import UIKit

class ChoosePaymentMethodTableViewCell: UITableViewCell {

    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func initUI(){
        checkButton.layer.cornerRadius = 15
        checkButton.clipsToBounds = true
    }
    
}
