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
        brandView.layer.cornerRadius = 10
        brandView.layer.shadowColor = UIColor.black.cgColor
        brandView.layer.shadowOffset = CGSize(width: 0, height: 2)
        brandView.layer.shadowRadius = 4
        brandView.layer.shadowOpacity = 0.2
        
        brandView.layer.borderColor = UIColor.lightGray.cgColor
        brandView.layer.borderWidth = 0.5
                brandTitle.textAlignment = .center
                brandTitle.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                }

}
