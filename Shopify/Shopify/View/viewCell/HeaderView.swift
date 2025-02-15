//
//  HeaderView.swift
//  Shopify
//
//  Created by Mai Atef  on 10/02/2025.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        headerLabel.textAlignment = .center
        
    }
    
}
