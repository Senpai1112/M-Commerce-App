//
//  ProductsViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 13/02/2025.
//

import UIKit
import Kingfisher

class ProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var Productscollection: UICollectionView!

    var products: [ProductModel] = []
    var filteredProducts: [ProductModel] = []
    var isFilterVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        Productscollection.dataSource = self
        Productscollection.delegate = self
        initNib()
        setupSlider()
        setupRightButt()
        filteredProducts = products
        mySlider.isHidden = true
        priceLabel.isHidden = true
        Productscollection.reloadData()
    }
    func initNib(){
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        Productscollection.register(nib, forCellWithReuseIdentifier: "ProductCell")
        
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
           let selectedPrice = sender.value
           priceLabel.text = "Price: \(selectedPrice)"

        filteredProducts = products.filter { Int(($0.price ?? 0)) <= Int(selectedPrice)
        }

           Productscollection.reloadData()
       }
       func setupSlider (){
           if let minPrice = products.map({ $0.price ?? 0 }).min(),
                      let maxPrice = products.map({ $0.price ?? 0 }).max() {
               mySlider.minimumValue = Float(minPrice)
               mySlider.maximumValue = Float(maxPrice)
               mySlider.value = Float(maxPrice)
               priceLabel.text = "Max: \(maxPrice)"
           }

       }
    
    func setupRightButt(){
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .done, target: self, action: #selector(isFilter))
        }
       
    @objc func isFilter() {
        if isFilterVisible {
            isFilterVisible = false
            mySlider.isHidden = true
            priceLabel.isHidden = true
        } else {
            isFilterVisible = true
            mySlider.isHidden = false
            priceLabel.isHidden = false
        }
    }


    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = filteredProducts[indexPath.item]

        if let price = product.price {
            cell.PriceLabel.text = "\(price)"
        }
        cell.currencyCodeLabel.text = product.currencyCode

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
