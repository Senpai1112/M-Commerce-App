//
//  ReviewsTableViewCell.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 24/02/2025.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        review?.numberOfLines = 4
        review?.lineBreakMode = .byWordWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
