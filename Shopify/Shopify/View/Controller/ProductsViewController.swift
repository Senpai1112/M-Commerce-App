//
//  ProductsViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 13/02/2025.
//

import UIKit
import Kingfisher

class ProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var Productscollection: UICollectionView!
    
    var products: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        Productscollection.dataSource = self
        Productscollection.delegate = self
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        Productscollection.register(nib, forCellWithReuseIdentifier: "ProductCell")
        
        
        Productscollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let product = products[indexPath.item]
        cell.titleLabel.text = product.title
        
        if let imageURL = product.image, let url = URL(string: imageURL) {
            cell.productImageView.kf.setImage(with: url, placeholder: UIImage(named: "1"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 2) - 10
        return CGSize(width: width, height: width)
    }
}
