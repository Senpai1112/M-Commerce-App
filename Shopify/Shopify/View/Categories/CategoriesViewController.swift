//
//  CategoriesViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 17/02/2025.
//

import UIKit

class CategoriesViewController: UIViewController ,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource , UISearchBarDelegate {
    
    @IBOutlet weak var CategoriesProductcollection: UICollectionView!
       var viewModel: ProductViewModel!
    
        var productKey = ""

       @IBOutlet weak var firstFilter: UISegmentedControl!
       @IBOutlet weak var secFilter: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        CategoriesProductcollection.dataSource = self
                CategoriesProductcollection.delegate = self

                initNib()
                
                viewModel = ProductViewModel()
                viewModel.bindProductsToViewController = {
                    DispatchQueue.main.async {
                        
                        self.CategoriesProductcollection.reloadData()
                    }
                }
        setQuery()

           // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = "Category"
        CategoriesProductcollection.reloadData()

    }
    func setUpSearchBar(){
        let searchBar = UISearchBar()
            searchBar.placeholder = "Search products..."
            searchBar.delegate = self
            searchBar.searchTextField.backgroundColor = .white

        self.tabBarController?.navigationItem.titleView = searchBar
    }
    @IBAction func firstFilterAction(_ sender: UISegmentedControl) {
        setQuery()
    }

    @IBAction func secFilterAction(_ sender: UISegmentedControl) {
        setQuery()
    }

    func setQuery() {
        var first = firstFilter.titleForSegment(at: firstFilter.selectedSegmentIndex) ?? ""
        let sec = secFilter.titleForSegment(at: secFilter.selectedSegmentIndex) ?? ""
        if first == "All" { first = "" }

        viewModel.getProductsFromModel(query: "\(first) | \(sec)")
    }

    func initNib(){
            let nib = UINib(nibName: "CategoryCell", bundle: nil)
            CategoriesProductcollection.register(nib, forCellWithReuseIdentifier: "CategoryCell")
            
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.finalResult.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
               let product = viewModel.finalResult[indexPath.item]

               if let price = product.price {
                   cell.PriceLabel.text = "\(price) "
               }
        cell.currencyCodeLabel.text = product.currencyCode
        cell.titleLabel.text = product.title
        cell.vendorLabel.text = product.vendor
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
               //cell.favButton.foregroundColor = .red
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
        guard let detailsVC = storyBord.instantiateViewController(withIdentifier: "detailsVC") as? ProductDetailsViewController else {
            return
        }
            detailsVC.id = viewModel.finalResult[indexPath.item].id
        
            print("Selected Product ID: \(detailsVC.id ?? "No ID")")
            print("Id:\(viewModel.finalResult[indexPath.item].id)")
            
            
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = (collectionView.bounds.width / 2)
        return CGSize(width: width - 5, height: width*1.4)
       }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            print("Search Text Changed: \(searchText)") // Print the search text
            var first = firstFilter.titleForSegment(at: firstFilter.selectedSegmentIndex) ?? ""
            let sec = secFilter.titleForSegment(at: secFilter.selectedSegmentIndex) ?? ""
            if first == "All" { first = "" }

        viewModel.getProductsFromModel(query: "\(first) | \(sec) | \(searchText)")
        }
}
