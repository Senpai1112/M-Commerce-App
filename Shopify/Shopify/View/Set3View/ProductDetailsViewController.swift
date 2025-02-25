//
//  ProductDetailsViewController.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 13/02/2025.
//
import UIKit
import MyApi

class ProductDetailsViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource ,UIScrollViewDelegate{
    
    // MARK: - Properties
    var viewModel = ProductDetailsViewModel()
    var lines : [CartLineInput] = []
    var addToCartViewModel = AddToCartViewModel()
    var id: String?
    var product: Product?
    
    // URLs for the images in the carousel
    lazy var urls: [Foundation.URL] = []
    
    // UI Components
    lazy var carousel = Carousel(frame: .zero, urls: urls)
    let imageIndicatorStackView = UIStackView()
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
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
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
        
        if let cartID = UserDefaults.standard.string(forKey: "cartID") {
            print("Retrieved Cart ID: \(cartID)")
        }
        
        setupHierarchy()
        setupComponents()
        setupConstraints()
        variantPicker.delegate = self
        variantPicker.dataSource = self
        scrollView.delegate = self
        print("Fetching product data...")
        setupViewModelObservers()
        viewModel.fetchProduct(pid: id ?? "gid://shopify/Product/7226328383543")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        let favIsSelected = UserDefaults.standard.bool(forKey: "\((id) ?? "")")
        //        favoriteButton.isSelected = favIsSelected
        //        if favIsSelected {
        //            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        //        } else {
        //            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        //        }
        checkIfFavorite()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemGray6
        self.view = view
    }
    
    // MARK: - Helper Methods
    func checkIfFavorite() {
        //        guard let product = product else { return }
        //
        //        let favoriteProducts = CoreDataManager.fetchFromCoreData()
        //
        //        for favorite in favoriteProducts {
        //            if favorite.productId == product.id {
        //                favoriteButton.isSelected = true
        //                favoriteButton.setImage(UIImage(named: "favoriteRed"), for: .normal)
        //                return
        //            }
        //        }
        //
        //        favoriteButton.isSelected = false
        //        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
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
            let alert = UIAlertController(title: "Alert", message: "You must log in to do this action.", preferredStyle: .alert)
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
            let selectedRow = variantPicker.selectedRow(inComponent: 0)
            let selectedVariant = product?.variants[selectedRow] ?? product?.variants.first
            
            if let variant = selectedVariant {
                lines = [CartLineInput(quantity: 1, merchandiseId: variant.id)]
                print("Add to Cart Tapped with Variant: \(variant.title), Price: \(variant.price.amount) \(variant.price.currencyCode)  ID: \(variant.id)")
                
                // Assuming cartID is retrieved and lines are properly populated
                if let cartID = UserDefaults.standard.string(forKey: "cartID") {
                    addToCartViewModel.addLineToCart(cartId: cartID, lines: lines)
                }
            }
            addToCartViewModel.onCartUpdated = { [weak self] cart in
                // Update UI with new cart data (e.g., navigate to checkout)
                let alertController = UIAlertController(title: "Success", message: "Item has been added to your cart.", preferredStyle: .alert)
                
                // Add an OK button to dismiss the alert
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                // Present the alert
                self?.present(alertController, animated: true, completion: nil)
                print("Cart updated: \(cart.id)")
                
                print("Checkout URL: \(cart.checkoutUrl ?? "No URL")")
            }
            
            viewModel.onError = { error in
                // Handle error (e.g., show alert to user)
                print("Error: \(error)")
            }
        }else {
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
    
    private func updateUI(with product: Product) {
        self.product = product
        titleLabel.text = product.title
       // priceLabel.text = "\(product.price) \(product.currecy)"
        if let firstVariant = product.variants.first {
                    priceLabel.text = "\(firstVariant.price.amount) \(firstVariant.price.currencyCode)"
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
        checkIfFavorite()
        variantPicker.selectRow(0, inComponent: 0, animated: false)

    }
    
    // MARK: - UI Setup
 
    func setupHierarchy(){
        self.view.addSubview(headerView)
        self.view.addSubview(carousel)
        self.view.addSubview(imageIndicatorStackView)
        self.view.addSubview(titleLabel)
       // self.view.addSubview(pickerTitleLabel)
        self.view.addSubview(variantPicker)
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
        imageIndicatorStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        variantPicker.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ASICS Tiger | GEL-LYTE V '30 YEARS OF GEL' PACK"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        
        priceLabel.text = "3447.38 EGP"
        priceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        priceLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "The iconic ASICS Tiger GEL-Lyte III was originally released in 1990. Having over two decades of performance heritage, it offers fine design detailing and a padded split tongue."
        descriptionLabel.numberOfLines = 0
        
        addToCartButton.setTitle("Add to Bag", for: .normal)
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
               
               carousel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
               carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               carousel.heightAnchor.constraint(equalToConstant: 250),
   
               titleLabel.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 4),
               titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               
               priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
               priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               
  
                       // Position the variant picker below stars
               variantPicker.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
               //variantPicker.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -16),
               variantPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               variantPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               variantPicker.heightAnchor.constraint(equalToConstant: 200), // Set a fixed height
              

               
               ratingAndReviewStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
               ratingAndReviewStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               ratingAndReviewStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
               
               descriptionStackView.topAnchor.constraint(equalTo: ratingAndReviewStackView.bottomAnchor, constant: 4),
               descriptionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               descriptionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               
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
        variantPicker.frame = CGRect(x: 0, y: 400, width: self.view.frame.width, height: 200)

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
    
    // MARK: - UIPickerView Delegate and DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return product?.variants.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return product?.variants[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let selectedVariant = product?.variants[row] {
            print("Price: \(selectedVariant.price.amount) \(selectedVariant.price.currencyCode) \(selectedVariant.id) \(selectedVariant.title)")
             lines = [CartLineInput(quantity: 1, merchandiseId: selectedVariant.id)]
              
        
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // Disable scrolling when interacting with the picker
        if variantPicker.isFirstResponder {
            scrollView.isScrollEnabled = false
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Re-enable scrolling after interacting with the picker
        scrollView.isScrollEnabled = true
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
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//
//extension ProductDetailsViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didScrollToItemAt indexPath: IndexPath) {
//        let selectedIndex = indexPath.row
//        updateIndicator(selectedIndex: selectedIndex)
//    }
//}
