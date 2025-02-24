//
//  HomeViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 10/02/2025.
//

import UIKit
import Kingfisher
import MyApi


class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var homeCollection: UICollectionView!
    let discountCoupon = ["SUMMER30" , "WINTER30"]
    var viewModel: BrandsViewModel!
    var filteredBrands: [BrandModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("EGP", forKey: "currencyCode")
        UserDefaults.standard.set(1.0 , forKey: "currencyValue")
        homeCollection.dataSource = self
        homeCollection.delegate = self
        initNib()
        compositionalLayout()
     
    }
   
    override func viewWillAppear(_ animated: Bool) {
        let titleLabel = UILabel()
            titleLabel.text = "Cartique"
            titleLabel.textColor = .white
            titleLabel.font = .boldSystemFont(ofSize: 25)
            
            if let customFont = UIFont(name: "Georgia-Italic", size: 20) {
                titleLabel.font = customFont
            }
            
            titleLabel.layer.shadowColor = UIColor.black.cgColor
            titleLabel.layer.shadowOffset = CGSize(width: 1, height: 2)
            titleLabel.layer.shadowOpacity = 0.4

        self.tabBarController?.navigationItem.titleView = titleLabel
        
        setupNavigationBarIcons()
        setupLeftBarButt()
        viewModel = BrandsViewModel()
        viewModel.bindBrandsToViewController = {
            DispatchQueue.main.async {
                
                self.homeCollection.reloadData()
            }}
            viewModel.getBrandsFromModel()

    }
    func compositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { index, environment in

            switch index {
            case 0:
                return self.drawAdsSection()
            case 1:
                return self.drawBrandSection()
                
           
            default: return nil
            }
        }
        self.homeCollection.setCollectionViewLayout(layout, animated: true)
    }
    func initNib() {
        let brandNib = UINib(nibName: "BrandCell", bundle: nil)
        homeCollection.register(brandNib, forCellWithReuseIdentifier: "BrandCell")
        
        let AdNib = UINib(nibName: "AdsCell", bundle: nil)
        homeCollection.register(AdNib, forCellWithReuseIdentifier: "AdsCell")
        
        let headerNib = UINib(nibName: "HeaderView", bundle: nil)
        homeCollection.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        
    }
    


    //header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            switch indexPath.section {
            case 0:
                header.headerLabel.text = ""
            case 1:
                header.headerLabel.text = "Brands"
            default: header.headerLabel.text = "Ads"
            }
            return header
        }
        return UICollectionReusableView()
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
       return 2
   }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
        return 2
        case 1:
            return viewModel.filteredCollections.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch (indexPath.section) {
        case 0:

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsCell", for: indexPath) as! AdsCell
                    cell.AdImage.image = UIImage(named: "summer")
                    return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandCell
            let brand = viewModel.filteredCollections[indexPath.row]

cell.brandTitle.text = brand.title
    if let imageURL = brand.image, let url = URL(string: imageURL) {
                cell.brandImage.kf.setImage(with: url, placeholder: UIImage(named: "1"))
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section) {
        case 0 :
            UIPasteboard.general.string = discountCoupon[indexPath.row]
            let alert = UIAlertController(title: "Discount coupon has been copied to clipboard!", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        case 1:
            let storyBord = UIStoryboard(name: "Set-1", bundle: nil)
            let productVC = storyBord.instantiateViewController(withIdentifier: "ProductVC") as! ProductsViewController
            productVC.title=viewModel.filteredCollections[indexPath.row].title
            productVC.products = viewModel.filteredCollections[indexPath.row].products
            navigationController?.pushViewController(productVC, animated: true)
        default:
            return
        }
    }
    
   
////drawing
func drawAdsSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
        
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
    widthDimension: .fractionalWidth(0.85),heightDimension: .absolute(180))
        
            let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,  subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            
            ////
            section.visibleItemsInvalidationHandler = { (items, offset, environment) in
                   let containerWidth = environment.container.contentSize.width

                   items.forEach { item in
                       let distanceFromCenter = abs(item.frame.midX - offset.x - containerWidth / 2)
            
                       let minScale: CGFloat = 0.8
                       let maxScale: CGFloat = 1.0
            
            let scale = max(maxScale - (distanceFromCenter / containerWidth), minScale)
                       
                       item.transform = CGAffineTransform(scaleX: scale, y: scale)
                   }
               }
    return section

        }

        func drawBrandSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(135)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 2
            )
            
            group.interItemSpacing = .fixed(10)
               
               let section = NSCollectionLayoutSection(group: group)
               
               section.interGroupSpacing = 10
               
               section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            

            return section
        }
    
    ////setupNavigationBarIcons
    func setupNavigationBarIcons() {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 10
            stackView.distribution = .equalSpacing
            
           
            let butt2 = UIButton(type: .system)
            setUpNavBarBtn(button: butt2, systemName: "heart", selector: #selector(favTapped))
            
            let butt3 = UIButton(type: .system)
            setUpNavBarBtn(button: butt3, systemName: "cart", selector: #selector(cartTapped))
            
            stackView.addArrangedSubview(butt3)
            stackView.addArrangedSubview(butt2)

            let barButtonItem = UIBarButtonItem(customView: stackView)
            tabBarController?.navigationItem.rightBarButtonItem = barButtonItem
        }
        
        @objc func searchTapped() {
            showSearchBar()
            
        }
        @objc func cartTapped() {
            if let accessToken = UserDefaults.standard.string(forKey: "accessToken"), !accessToken.isEmpty {
                let storyBord = UIStoryboard(name: "Set2", bundle: nil)
                let cartVc = storyBord.instantiateViewController(withIdentifier: "ShoppingCartViewController") as! ShoppingCartViewController
                navigationController?.pushViewController(cartVc, animated: true)
            } else {
                showLoginAlert()
            }
        }
    @objc func favTapped() {
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken"), !accessToken.isEmpty {
                let storyBord = UIStoryboard(name: "Set3", bundle: nil)
                let favouritesVC = storyBord.instantiateViewController(withIdentifier: "favouritesVC") as! FavouritesViewController
                navigationController?.pushViewController(favouritesVC, animated: true)
            } else {
                showLoginAlert()
            }
    }
    func showLoginAlert() {
            let alert = UIAlertController(title: "Alert", message: "You must log in to access this page.", preferredStyle: .alert)
            let loginAction = UIAlertAction(title: "Log In", style: .default) { _ in
                let storyBord = UIStoryboard(name: "Set3", bundle: nil)
                let loginVC = storyBord.instantiateViewController(withIdentifier: "loginVC") as! LoginCustomerViewController
                self.navigationController?.pushViewController(loginVC, animated: true)        }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(loginAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    
    func showSearchBar() {
        let searchBar = UISearchBar()
            searchBar.placeholder = "Search Brands..."
            searchBar.delegate = self
            searchBar.searchTextField.backgroundColor = .white
        searchBar.showsCancelButton = true
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
           self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.titleView = searchBar
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
    
    }

   
    
    func hideSearchBar() {
        self.tabBarController?.navigationItem.titleView = nil
        let titleLabel = UILabel()
            titleLabel.text = "Cartique"
            titleLabel.textColor = .white
            titleLabel.font = .boldSystemFont(ofSize: 25)
            
            if let customFont = UIFont(name: "Georgia-Italic", size: 20) {
                titleLabel.font = customFont
            }
            
            titleLabel.layer.shadowColor = UIColor.black.cgColor
            titleLabel.layer.shadowOffset = CGSize(width: 1, height: 2)
            titleLabel.layer.shadowOpacity = 0.4

        self.tabBarController?.navigationItem.titleView = titleLabel
        setupNavigationBarIcons()
        setupLeftBarButt()

    }
    
   
    
    
    func setUpNavBarBtn(button: UIButton, systemName: String, selector: Selector) {
        if let icon = UIImage(systemName: systemName) {
            button.setImage(icon, for: .normal)
        }
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    ////search
       
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

                   print("Search Text Changed: \(searchText)")
             
                   viewModel.searchText = searchText

                   homeCollection.reloadData()
               }
    
    
    func setupLeftBarButt() {
        let searchButt = UIButton(type: .system)
        setUpNavBarBtn(button: searchButt, systemName: "magnifyingglass", selector: #selector(searchTapped))
        
        let barButtonItem = UIBarButtonItem(customView: searchButt)
        self.tabBarController?.navigationItem.leftBarButtonItem = barButtonItem
    }

}
