//
//  ShoppingCartTableViewCell.swift
//  Shopify
//
//  Created by Yasser Yasser on 10/02/2025.
//

import UIKit

protocol ShoppingCartTableViewCellDelegate{
    func removeCell(at indexPath: IndexPath)
}

class ShoppingCartTableViewCell: UITableViewCell {
    

    var delegate : ShoppingCartTableViewCellDelegate?
    private var indexPath :IndexPath?
    
    @IBOutlet weak var productQuantaty: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func initUI(){
        plusButton.layer.cornerRadius = 15
        plusButton.clipsToBounds = true
        
        minusButton.layer.cornerRadius = 15
        minusButton.clipsToBounds = true

        productImage.layer.cornerRadius = 50
        
        productPrice.textColor = .systemRed
    }
    
    func configure(with indexPath :IndexPath){
        self.indexPath = indexPath
    }
    
    @IBAction func tabPlusButton(_ sender: Any) {
        var num = Int(productQuantaty.text!)
        num! += 1
        productQuantaty.text = num!.codingKey.stringValue
    }
    @IBAction func tabMinusButton(_ sender: Any) {
        let num = Int(productQuantaty.text!)
        if var num = num {
            if num > 1{
                num -= 1
                productQuantaty.text = num.codingKey.stringValue
            }
            else{
                delegate?.removeCell(at: self.indexPath!)
            }
        }
        
    }
}
