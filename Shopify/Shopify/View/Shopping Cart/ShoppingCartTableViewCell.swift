//
//  ShoppingCartTableViewCell.swift
//  Shopify
//
//  Created by Yasser Yasser on 10/02/2025.
//

import UIKit

protocol ShoppingCartTableViewCellDelegate{
    func removeCell(at indexPath: IndexPath)
    func quantityDidChange(for: IndexPath , newQuantity: Int)
}

class ShoppingCartTableViewCell: UITableViewCell {
    
    
    var delegate : ShoppingCartTableViewCellDelegate?
    private var indexPath :IndexPath?
    var cartViewModel: CartViewModel!
    private var currentQuantity: Int = 0
    
    @IBOutlet weak var productDetails: UILabel!
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
        plusButton.tintColor = UIColor.purple

        minusButton.layer.cornerRadius = 15
        minusButton.clipsToBounds = true
        minusButton.tintColor = UIColor.purple

        productImage.layer.cornerRadius = 50
        
        productPrice.textColor = .systemRed
    }
    
    func configure(with indexPath: IndexPath, quantity: Int) {
        self.indexPath = indexPath
        self.currentQuantity = quantity
        self.productQuantaty.text = "\(quantity)"
    }
    
    @IBAction func tabPlusButton(_ sender: Any) {
        guard let totalQuantity = cartViewModel.localCartResult.cart?[indexPath!.row].merchandise?.availableQuantity,
              currentQuantity < totalQuantity else {
            print("Maximum number of quantities reached")
            return
        }
        currentQuantity += 1
        productQuantaty.text = "\(currentQuantity)"

        delegate?.quantityDidChange(for: indexPath!, newQuantity: currentQuantity)
    }
    @IBAction func tabMinusButton(_ sender: Any) {
        if currentQuantity > 1 {
            currentQuantity -= 1
            productQuantaty.text = "\(currentQuantity)"
            delegate?.quantityDidChange(for: indexPath!, newQuantity: currentQuantity)
        } else {
            delegate?.removeCell(at: indexPath!)
        }
        
    }
}
