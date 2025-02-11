//
//  BrandCell.swift
//  Shopify
//
//  Created by Mai Atef  on 10/02/2025.
//

import UIKit

class BrandCell: UICollectionViewCell {
    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var brandTitle: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        brandView.layer.cornerRadius = 15
        brandView.layer.borderColor = UIColor.lightGray.cgColor
        brandView.layer.borderWidth = 0.5
                
                brandImage.contentMode = .scaleAspectFit
                brandImage.clipsToBounds = true
                
                brandTitle.textAlignment = .center
                brandTitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                }

}
