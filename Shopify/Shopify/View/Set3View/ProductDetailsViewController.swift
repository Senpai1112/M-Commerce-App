//
//  ProductDetailsViewController.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 13/02/2025.
//
import UIKit
import MyApi

class ProductDetailsViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource  {
    
    // MARK: - Properties
    var viewModel = ProductDetailsViewModel()
    var lines : [CartLineInput] = []
    var addToCartViewModel = AddToCartViewModel()
    var id: String?
    var product: Product?
    var activityIndicator: UIActivityIndicatorView!
    let variantTableView = UITableView()
    // URLs for the images in the carousel
    lazy var urls: [Foundation.URL] = []
    
    // UI Components
    lazy var carousel = Carousel(frame: .zero, urls: urls)
//    let imageIndicatorStackView = UIStackView()
    let variantPicker = UIPickerView()
    
    // Description and Rating Section
    let descriptionStackView = UIStackView()
    let descriptionLabel = UILabel()
    let ratingStackView = UIStackView()
   
    let ratingAndReviewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let pickerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // Product Title, Price, and Buttons Section
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let buttonsStackView = UIStackView()
    let addToCartButton = UIButton(type: .system)
    let favoriteButton = UIButton(type: .system)
    let reviewButton = UIButton(type: .system)
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let staticDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .purple
        label.textAlignment = .left
        return label
    }()
    let pickerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Size & Color"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .purple
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"
        print("Product ID: \(id ?? "No ID")")
        variantTableView.backgroundColor = .systemGray6
        if let cartID = UserDefaults.standard.string(forKey: "cartID") {
            print("Retrieved Cart ID: \(cartID)")
        }
        if let value = UserDefaults.standard.string(forKey: "accessToken") {
            print("accessToken \(value) from user default")
        }
        if let valueId = UserDefaults.standard.string(forKey: "customerID") {
            print("customerID from user default\(valueId)")
        }
        if let currencyCode = UserDefaults.standard.string(forKey: "currencyCode") {
            print("currencyCode from user default\(currencyCode)")
        }
        let currencyValue = UserDefaults.standard.integer(forKey: "currencyValue")
            print("currencyValue from user default\(currencyValue)")
        if let customerName = UserDefaults.standard.string(forKey: "customerFirstName") {
            print("name from user default\(customerName)")
        }
        if let customerEmail = UserDefaults.standard.string(forKey: "customerEmail") {
            print("mail from user default\(customerEmail)")
        }
        
        setupHierarchy()
        setupComponents()
        setupConstraints()
        variantTableView.delegate = self
        variantTableView.dataSource = self
        
        variantTableView.register(UITableViewCell.self, forCellReuseIdentifier: "variantCell")
      //  variantPicker.delegate = self
     //   variantPicker.dataSource = self
        print("Fetching product data...")
//        setupViewModelObservers()
//        viewModel.fetchProduct(pid: id ?? "gid://shopify/Product/7226328383543")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupActivityIndicator()
        activityIndicator.startAnimating()
        setupViewModelObservers()
        viewModel.fetchProduct(pid: id ?? "gid://shopify/Product/7226328383543")
        checkIfFavorite()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemGray6
        self.view = view
    }
    
    // MARK: - Helper Methods
    func checkIfFavorite() {
              guard let product = product else { return }
        
        let favoriteProducts = CoreDataManager.fetchFromCoreData()
        
        for favorite in favoriteProducts {
            if favorite.productId == product.id {
                favoriteButton.isSelected = true
                favoriteButton.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
                return
            }
        }
        
        favoriteButton.isSelected = false
        favoriteButton.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @objc func toggleFavorite() {
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken"), !accessToken.isEmpty {
            
            guard let product = product else { return }
            favoriteButton.isSelected = !favoriteButton.isSelected
            
            if favoriteButton.isSelected {
                favoriteButton.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
                CoreDataManager.saveProductToCoreData(productName: product.title, productPrice: product.price, productImage: product.images.first ?? "", productId: product.id)
                UserDefaults.standard.set(true, forKey: "\((id) ?? "")")
            } else {
                let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion?", preferredStyle: .alert)
                
                //AddAction
                alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [self] action in
                    favoriteButton.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal), for: .normal)
                    CoreDataManager.deleteFromCoreData(productId: product.id)
                    UserDefaults.standard.set(false, forKey: "\((id) ?? "")")
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel , handler: { action in
                }))
                

                //showAlert
                self.present(alert, animated: true) {
                }
                
            }
        } else {
            showLoginAlert()
        }
    }
    
    func showLoginAlert() {
            let alert = UIAlertController(title: "Login Required", message: "Please log in to do this action.", preferredStyle: .alert)
            let loginAction = UIAlertAction(title: "Log In", style: .default) { _ in
                let storyBord = UIStoryboard(name: "Set3", bundle: nil)
                let loginVC = storyBord.instantiateViewController(withIdentifier: "loginVC") as! LoginCustomerViewController
                self.navigationController?.pushViewController(loginVC, animated: true)        }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(loginAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
     
    @objc func addToCartTapped() {
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken"), !accessToken.isEmpty {
            if let selectedIndexPath = variantTableView.indexPathForSelectedRow {
                let selectedVariant = product?.variants[selectedIndexPath.row] ?? product?.variants.first
                
                if let variant = selectedVariant {
                    lines = [CartLineInput(quantity: 1, merchandiseId: variant.id)]
                    print("Add to Cart Tapped with Variant: \(variant.title), Price: \(variant.price.amount) \(variant.price.currencyCode)  ID: \(variant.id)")
                    
                    if let cartID = UserDefaults.standard.string(forKey: "cartID") {
                        addToCartViewModel.addLineToCart(cartId: cartID, lines: lines)
                    }
                }
                variantTableView.deselectRow(at: selectedIndexPath, animated: true)
                addToCartViewModel.onCartUpdated = { [weak self] cart in
                    let alertController = UIAlertController(title: "Success", message: "Item has been added to your cart.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                }
                
                viewModel.onError = { error in
                    print("Error: \(error)")
                }
            } else {
                // Show an alert if no row is selected
                let alert = UIAlertController(title: "No Size Or Color Selected", message: "Please select size & color before adding to cart.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
        }else{
            showLoginAlert()
        }
    }

    
    private func setupViewModelObservers() {
        viewModel.onProductFetched = { [weak self] product in
            self?.updateUI(with: product)
        }
        
        viewModel.onError = { errorMessage in
            print("Error: \(errorMessage)")
        }
    }
    func mapCost(amount: String?, currencyCode: String?) -> Double? {
            guard let amount = amount else { return nil }
            let doubleCost = (Double(amount) ?? 0.0) * UserDefaults.standard.double(forKey: "currencyValue")
            let formattedPrice = (doubleCost * 100).rounded() / 100
            return formattedPrice
        }
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    private func updateUI(with product: Product) {
        
        self.product = product
        titleLabel.text = product.title
       // priceLabel.text = "\(product.price) \(product.currecy)"
        if let firstVariant = product.variants.first {
                    priceLabel.text = "\(firstVariant.price.amount) \(firstVariant.price.currencyCode)"
            priceLabel.text = "\(mapCost(amount: firstVariant.price.amount, currencyCode: firstVariant.price.currencyCode) ?? 0.0) \(UserDefaults.standard.string(forKey: "currencyCode") ?? "")"

                }
        descriptionLabel.text = product.description
        
        print("Product Data Fetched Successfully:")
        print("ID: \(product.id)")
        print("Title: \(product.title)")
        print("Description: \(product.description)")
        print("Available for Sale: \(product.availableForSale ? "Yes" : "No")")
        print("Total Inventory: \(product.totalInventory)")
        print("Price: \(product.price) EGP")
        
        print("\n Images:")
        for imageUrl in product.images {
            print("   - \(imageUrl)")
        }
        
        print("\n Variants:")
        for variant in product.variants {
            print("   - Price: \(variant.price.amount) \(variant.price.currencyCode)")
        }
        
        if !product.images.isEmpty {
            let urls = product.images.compactMap { URL(string: $0) }
            DispatchQueue.main.async {
                self.carousel.updateImages(with: urls)
            }
        }
        activityIndicator.stopAnimating()

        variantTableView.reloadData()
        checkIfFavorite()

    }
    
    // MARK: - UI Setup
 
    func setupHierarchy(){
        self.view.addSubview(headerView)
        self.view.addSubview(carousel)
        self.view.addSubview(titleLabel)
       // self.view.addSubview(pickerTitleLabel)
        self.view.addSubview(variantTableView)
        self.view.addSubview(priceLabel)
        self.view.addSubview(ratingAndReviewStackView)
        self.view.addSubview(descriptionStackView)
        self.view.addSubview(ratingStackView)
        self.view.addSubview(buttonsStackView)
        
        descriptionStackView.addArrangedSubview(staticDescriptionLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionStackView.addArrangedSubview(pickerTitleLabel)

        ratingStackView.addArrangedSubview(createRatingStars(rating: 4))
       // ratingStackView.addArrangedSubview(reviewButton)
        ratingAndReviewStackView.addArrangedSubview(ratingStackView)
        ratingAndReviewStackView.addArrangedSubview(reviewButton)
        
        buttonsStackView.addArrangedSubview(favoriteButton)
        buttonsStackView.addArrangedSubview(addToCartButton)
    }
    func setupComponents() {
        carousel.translatesAutoresizingMaskIntoConstraints = false
  //      imageIndicatorStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
      //  variantPicker.translatesAutoresizingMaskIntoConstraints = false
        variantTableView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ASICS Tiger | GEL-LYTE V '30 YEARS OF GEL' PACK"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        
        priceLabel.text = "3447.38 EGP"
        priceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        priceLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "The iconic ASICS Tiger GEL-Lyte III was originally released in 1990. Having over two decades of performance heritage, it offers fine design detailing and a padded split tongue."
        descriptionLabel.numberOfLines = 0
        
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.backgroundColor = .purple
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.layer.cornerRadius = 25
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        addToCartButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        
        favoriteButton.tintColor = UIColor(white: 0.95, alpha: 1.2)
  
        favoriteButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        descriptionStackView.axis = .vertical
        descriptionStackView.spacing = 4
        
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 16
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 16
        buttonsStackView.distribution = .fillEqually
        
        reviewButton.setTitle("Reviews", for: .normal)
        reviewButton.addTarget(self, action: #selector(navigateToReviews), for: .touchUpInside)
        
        ratingAndReviewStackView.axis = .horizontal
            ratingAndReviewStackView.spacing = 160
            ratingAndReviewStackView.alignment = .center
    }
 
    func setupConstraints() {
           NSLayoutConstraint.activate([
               headerView.topAnchor.constraint(equalTo: view.topAnchor),
               headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               headerView.heightAnchor.constraint(equalToConstant: 80),
               
               carousel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
               carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               carousel.heightAnchor.constraint(equalToConstant: 250),
   
               titleLabel.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 4),
               titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               
               priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
               priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

               ratingAndReviewStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
               ratingAndReviewStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               ratingAndReviewStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
               
               descriptionStackView.topAnchor.constraint(equalTo: ratingAndReviewStackView.bottomAnchor, constant: 4),
               descriptionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               descriptionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               
               variantTableView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 4),
               variantTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               variantTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
              // variantTableView.heightAnchor.constraint(equalToConstant: 80),
               variantTableView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -16),

               
             
               
              
               
               buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
               buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
               
               addToCartButton.widthAnchor.constraint(equalToConstant: 160),
               addToCartButton.heightAnchor.constraint(equalToConstant: 50),
               favoriteButton.widthAnchor.constraint(equalToConstant: 60),
               favoriteButton.heightAnchor.constraint(equalToConstant: 50)
           ])
           buttonsStackView.distribution = .fill

       }
    
    func createRatingStars(rating: Int) -> UIStackView {
        let ratingStackView = UIStackView()
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 4
        for i in 1...5 {
            let star = UIImageView()
            star.image = UIImage(systemName: i <= rating ? "star.fill" : "star")
            star.tintColor = .orange
            ratingStackView.addArrangedSubview(star)
        }
        return ratingStackView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product?.variants.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "variantCell", for: indexPath)
        if let variant = product?.variants[indexPath.row] {
            cell.textLabel?.text = variant.title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedVariant = product?.variants[indexPath.row] {
            print("Selected Variant: \(selectedVariant.title), Price: \(selectedVariant.price.amount) \(selectedVariant.price.currencyCode)")
            lines = [CartLineInput(quantity: 1, merchandiseId: selectedVariant.id)]
        }
    }
    
    // MARK: - Navigate to Reviews
    @objc func navigateToReviews() {
        // Navigate to the reviews screen
        print("Navigating to reviews...")
        let storyboard = UIStoryboard(name: "Set3", bundle: nil)
        if let reviewsViewController = storyboard.instantiateViewController(withIdentifier: "reviewsVC") as? ReviewsTableViewController {
            self.navigationController?.pushViewController(reviewsViewController, animated: true)
        }
    }
    
}

