//
//  AdsCell.swift
//  Shopify
//
//  Created by Mai Atef  on 14/02/2025.
//

import UIKit

class AdsCell: UICollectionViewCell {
    
    @IBOutlet weak var AdImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        AdImage.layer.cornerRadius = 10
        AdImage.contentMode = .scaleAspectFill
        AdImage.clipsToBounds = true

    }
}
