//
//  CategoriesViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 17/02/2025.
//

import UIKit

class CategoriesViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var CategoriesProductcollection: UICollectionView!
       var viewModel: ProductViewModel!
    
        var productKey = ""

       @IBOutlet weak var firstFilter: UISegmentedControl!
       @IBOutlet weak var secFilter: UISegmentedControl!

    var activityIndicator: UIActivityIndicatorView!

    var searchBar: UISearchBar?
    var emptyStateView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoriesProductcollection.dataSource = self
        CategoriesProductcollection.delegate = self
        initNib()
        emptyState ()
        
    }
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func updateEmptyState() {
            if viewModel.finalResult.isEmpty {
                emptyStateView?.isHidden = false
                CategoriesProductcollection.isHidden = true
            } else {
                emptyStateView?.isHidden = true
                CategoriesProductcollection.isHidden = false
            }
        }
    func emptyState (){
        if let emptyStateView = emptyStateView {
            emptyStateView.isHidden = true
            view.addSubview(emptyStateView)
            emptyStateView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                emptyStateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
                emptyStateView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
            ])
        }
    }
    override func viewWillAppear(_ animated: Bool) {

        CategoriesProductcollection.reloadData()
        setupActivityIndicator()
        setupNavigationBarIcons()
        setupLeftBarButt()
        viewModel = ProductViewModel()
        activityIndicator.startAnimating()
        viewModel.bindProductsToViewController = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating() 
                self.CategoriesProductcollection.reloadData()
                self.updateEmptyState()

            }
        }
        
        setQuery()
    }
    
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
        
        @objc func cartTapped() {
            if let accessToken = UserDefaults.standard.string(forKey: "accessToken"), !accessToken.isEmpty {
                let storyBord = UIStoryboard(name: "Set2", bundle: nil)
                let cartVc = storyBord.instantiateViewController(withIdentifier: "ShoppingCartViewController") as! ShoppingCartViewController
                navigationController?.pushViewController(cartVc, animated: true)
            } else {
                showLoginAlert()
            }
        }
    @objc func searchTapped() {
        showSearchBar()
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
            let alert = UIAlertController(title: "Login Required", message: "You must log in to access this page.", preferredStyle: .alert)
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
        searchBar = UISearchBar()
        searchBar?.placeholder = "Search products..."
        searchBar?.delegate = self
        searchBar?.searchTextField.backgroundColor = .white
        searchBar?.showsCancelButton = true
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
    
    func setupLeftBarButt() {
        let searchButt = UIButton(type: .system)
        setUpNavBarBtn(button: searchButt, systemName: "magnifyingglass", selector: #selector(searchTapped))
        
        let barButtonItem = UIBarButtonItem(customView: searchButt)
        self.tabBarController?.navigationItem.leftBarButtonItem = barButtonItem
    }
    func setUpNavBarBtn(button: UIButton, systemName: String, selector: Selector) {
        if let icon = UIImage(systemName: systemName) {
            button.setImage(icon, for: .normal)
        }
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }


    @IBAction func firstFilterAction(_ sender: UISegmentedControl) {
        setQuery()
    }

    @IBAction func secFilterAction(_ sender: UISegmentedControl) {
        setQuery()
    }

    func setQuery() {
        var first = firstFilter.titleForSegment(at: firstFilter.selectedSegmentIndex) ?? ""
        var sec = secFilter.titleForSegment(at: secFilter.selectedSegmentIndex) ?? ""
        
        if first == "All" { first = "" }
        if sec == "All" { sec = "" }
        
        var result = ""
        
        if !first.isEmpty && !sec.isEmpty {
            result = "\(first)|\(sec)"
        } else {
            result = first + sec
        }
        
        print(result)
        viewModel.getProductsFromModel(query: result)
    }


    func initNib(){
            let nib = UINib(nibName: "CategoryCell", bundle: nil)
            CategoriesProductcollection.register(nib, forCellWithReuseIdentifier: "CategoryCell")
        let emptyStateNib = UINib(nibName: "EmptyStateView", bundle: nil)
              emptyStateView = emptyStateNib.instantiate(withOwner: nil, options: nil).first as? UIView
            
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
       
        // Check if accessToken exists
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken"), !accessToken.isEmpty {
            // Handle favorite button based on the access token and user's preference
            var favIsSelected = UserDefaults.standard.bool(forKey: productKey)
            
            cell.favButton.isSelected = favIsSelected
            
            if favIsSelected {
                cell.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.favButton.tintColor = .white
            } else {
                cell.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                cell.favButton.tintColor = .white
            }
            
            cell.addToFavList = { [unowned self] in
                cell.favButton.isSelected = !cell.favButton.isSelected
                
                if cell.favButton.isSelected {
                    cell.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    cell.favButton.tintColor = .white
                    
                    // Save to Core Data and update UserDefaults
                    CoreDataManager.saveProductToCoreData(productName: product.title ?? "", productPrice: "\(product.price ?? 0)", productImage: product.image ?? "", productId: product.id ?? "")
                    UserDefaults.standard.set(true, forKey: "\(product.id ?? "")")
                } else {
                    let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion?", preferredStyle: .alert)
                    
                    //AddAction
                    alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [self] action in
                        cell.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                        cell.favButton.tintColor = .white
                        
                        // Delete from Core Data and update UserDefaults
                        CoreDataManager.deleteFromCoreData(productId: product.id ?? "")
                        UserDefaults.standard.set(false, forKey: "\(product.id ?? "")")
                    }))
                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel , handler: { action in
                    }))
                    

                    //showAlert
                    self.present(alert, animated: true) {
                    }
                    
                }
            }
        } else {
            cell.addToFavList = { [unowned self] in
                showLoginAlert()
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
        var first = firstFilter.titleForSegment(at: firstFilter.selectedSegmentIndex) ?? ""
        var sec = secFilter.titleForSegment(at: secFilter.selectedSegmentIndex) ?? ""
        
        if first == "All" { first = "" }
        if sec == "All" { sec = "" }
        
        var result = ""
        if !first.isEmpty && !sec.isEmpty {
            result = "\(first)|\(sec)"
        } else {
            result = first + sec
        }
        if searchText.isEmpty {
            viewModel.getProductsFromModel(query: result)
        } else {
            viewModel.getProductsFromModel(query: "\(result)|\(searchText)")
        }
    }

}
