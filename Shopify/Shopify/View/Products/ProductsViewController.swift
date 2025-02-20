//
//  ProductsViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 13/02/2025.
//

import UIKit
import Kingfisher

class ProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var Productscollection: UICollectionView!
    @IBOutlet weak var productsSearchBar: UISearchBar!
    
    var products: [ProductModel] = []
    var filteredProducts: [ProductModel] = []
    var isFilterVisible = false
    var currentPriceFilter: Int = 0
    
    var productKey = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        applyfilters()
        Productscollection.reloadData()
    }
    func initNib(){
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        Productscollection.register(nib, forCellWithReuseIdentifier: "ProductCell")
        
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
           let selectedPrice = sender.value
           priceLabel.text = "Price: \(selectedPrice)"
        currentPriceFilter = Int(selectedPrice)
        applyfilters()
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
               currentPriceFilter = Int(maxPrice)
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
        productKey = "\((product.id) ?? "")"
       
       var favIsSelected =  UserDefaults.standard.bool(forKey: productKey)

      cell.favButton.isSelected =   UserDefaults.standard.bool(forKey: productKey)
       
       if UserDefaults.standard.bool(forKey: productKey){
           cell.favButton.setImage(UIImage(named: "favoriteRed"), for: .normal)
           cell.favButton.tintColor = .white

             }else{
                 cell.favButton.setImage(UIImage(systemName: "heart"), for: .normal)

                 cell.favButton.tintColor = .white
           }
           

       cell.addToFavList = { [unowned self] in

           cell.favButton.isSelected = !cell.favButton.isSelected
           if  cell.favButton.isSelected {

               cell.favButton.setImage(UIImage(named: "favoriteRed"), for: .normal)
               cell.favButton.tintColor = .white
               
                // save to core data
               CoreDataManager.saveProductToCoreData(productName: product.title ?? "", productPrice: "\(product.price)", productImage: product.image ?? "", productId: product.id ?? "")
                    
                 UserDefaults.standard.set(true,forKey: "\(product.id ?? "")")

                }else{
                    // delete from core data and change state
                    cell.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    cell.favButton.tintColor = .white

                    CoreDataManager.deleteFromCoreData(productId: product.id ?? "" )
                    UserDefaults.standard.set(false,
                                              forKey: "\(product.id ?? "")")
                }
      }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let storyBord = UIStoryboard(name: "Set3", bundle: nil)
         let detailsVC = storyBord.instantiateViewController(withIdentifier: "detailsVC") as! ProductDetailsViewController
        print("id:\(products[indexPath.item].id)")
           detailsVC.id = products[indexPath.item].id
        navigationController?.pushViewController(detailsVC, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 2) - 10
        return CGSize(width: width, height: width)
    }
    ////search
     func setUpSearchBar(){
    
         productsSearchBar.placeholder = "Search Products..."
         productsSearchBar.delegate = self

}
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
                print("Search Text Changed: \(searchText)")
        applyfilters()
        Productscollection.reloadData()

            }
    func applyfilters()
    {
        let searchText = productsSearchBar.text ?? ""

                filteredProducts = products.filter { product in
                    let matchesTitle = searchText.isEmpty || (product.title?.lowercased().contains(searchText.lowercased()) ?? false)
                    let matchesPrice = Int((product.price ?? Double(currentPriceFilter) )) <=  currentPriceFilter

                    return matchesTitle && matchesPrice
                }

                Productscollection.reloadData()
    }
}
