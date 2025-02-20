//
//  ProductDetailsViewController.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 13/02/2025.
//
import UIKit



class ProductDetailsViewController: UIViewController, CarouselDelegate {
    var viewModel = ProductDetailsViewModel()

    var id : String?
    // URLs for the images in the carousel
   lazy var urls: [Foundation.URL] = []
//        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png")!,
//        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png")!,
//        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/3.png")!
//    ]
    
    // Instantiate the carousel with the image URLs
    lazy var carousel = Carousel(frame: .zero, urls: urls)
//    let titleb : String
    // Image indicator (dots) below the carousel
    let imageIndicatorStackView = UIStackView()
    var indicatorViews: [UIView] = []
    
    // Section for description and rating
    let descriptionStackView = UIStackView()
    let descriptionLabel = UILabel()
    let ratingStackView = UIStackView()
    
    // Section for product title, price and buttons (Add to Cart, Add to Favorites)
    let titleLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
       // label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping 
        return label
    }()
    var priceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16,weight: .bold)
        label.textColor = .black

        return label
    }()
    let buttonsStackView = UIStackView()
    let addToCartButton = UIButton(type: .system)
    let favoriteButton = UIButton(type: .system)

    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
//
//    let titlebar: UILabel = {
//        let label = UILabel()
//        label.text = "Product Details"
//        label.textColor = .white
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    let staticDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"  //  Static label text
        label.font = UIFont.boldSystemFont(ofSize: 18) //  Make it bold
        label.textColor = .purple
        label.textAlignment = .left
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"
        print("Product ID: \(id ?? "No ID")")
        setupHierarchy()
        setupComponents()
        setupConstraints()
        setupIndicator()
        carousel.delegate = self
        
        print("Fetching product data...")
        setupViewModelObservers()
        viewModel.fetchProduct(pid: id ?? "gid://shopify/Product/7226328383543" )
      //  fetchProductData()
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemGray6
        self.view = view
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
        //  Update Title, Price, and Description
        titleLabel.text = product.title
        priceLabel.text = "\(product.price) \(product.currecy)"
        descriptionLabel.text = product.description
        print("Product Data Fetched Successfully:")
        print("ID: \(product.id)")
        print("Title: \(product.title)")
       // titleb = product.title
        print("Description: \(product.description)")
        print("Available for Sale: \(product.availableForSale ? "Yes" : "No")")
        print("Total Inventory: \(product.totalInventory)")
        print("Price: \(product.price) EGP")
        
        print("\n Images:")
        for imageUrl in product.images {
            print("   - \(imageUrl)")
                  }
        print("\n Variants:")
        for variant in product.adjacentVariants {
               print("   - Price: \(variant.price.amount) \(variant.price.currencyCode)")
                            }
        //  Update Images in the Carousel
        if !product.images.isEmpty {
            let urls = product.images.compactMap { URL(string: $0) }
            
            DispatchQueue.main.async {
                self.carousel.updateImages(with: urls) // Call the method to update carousel
            }
        }
    }
    
    // Set up the view hierarchy
    func setupHierarchy() {
        self.view.addSubview(headerView)
        self.view.addSubview(carousel)
        self.view.addSubview(imageIndicatorStackView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(priceLabel)
        self.view.addSubview(descriptionStackView) // Add description section
        self.view.addSubview(ratingStackView) // Add rating section
        self.view.addSubview(buttonsStackView) // Add buttons section
        
        // Add description to descriptionStackView
        descriptionStackView.addArrangedSubview(staticDescriptionLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        
        // Add rating to ratingStackView (using stars)
        ratingStackView.addArrangedSubview(createRatingStars(rating: 4))
        
        // Add buttons to buttonsStackView
        buttonsStackView.addArrangedSubview(favoriteButton)
        buttonsStackView.addArrangedSubview(addToCartButton)
    }

    // Set up components
    func setupComponents() {
        carousel.translatesAutoresizingMaskIntoConstraints = false
        imageIndicatorStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        // Set up title label
        titleLabel.text = "ASICS Tiger | GEL-LYTE V '30 YEARS OF GEL' PACK"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        
        // Set up price label
        priceLabel.text = "3447.38 EGP"
        priceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        priceLabel.textColor = .black
        
        // Set up description
        descriptionLabel.text = "The iconic ASICS Tiger GEL-Lyte III was originally released in 1990. Having over two decades of performance heritage, it offers fine design detailing and a padded split tongue."
        descriptionLabel.numberOfLines = 0
        
        // Set up buttons
        addToCartButton.setTitle("Add to Bag", for: .normal)
        addToCartButton.backgroundColor = .purple
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.layer.cornerRadius = 25 // Rounded corners for the button
        addToCartButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteButton.tintColor = .lightGray
        favoriteButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // Set up stack views
        descriptionStackView.axis = .vertical  //Stack items in a column
            descriptionStackView.spacing = 4
        
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 4
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 16
        buttonsStackView.distribution = .fillEqually
    }

    // Set up constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80), // Adjust height
               
               //Carousel Below Header
            carousel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            carousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carousel.heightAnchor.constraint(equalToConstant: 250),

            // Image indicator constraints
            imageIndicatorStackView.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 8),
            imageIndicatorStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageIndicatorStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageIndicatorStackView.heightAnchor.constraint(equalToConstant: 8),
            imageIndicatorStackView.bottomAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 16),

            // Title constraints
            titleLabel.topAnchor.constraint(equalTo: imageIndicatorStackView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Price constraints
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // Rating constraints
            ratingStackView.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8),
            ratingStackView.topAnchor.constraint(equalTo: priceLabel.topAnchor),
            
            // Description constraints
            descriptionStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            descriptionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Buttons constraints
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

    // Set up the indicator
    func setupIndicator() {
        for _ in urls {
            let indicatorDot = createIndicatorDot() // Create a single dot (UIView)
            indicatorViews.append(indicatorDot) // Add the dot to the array of indicators
            imageIndicatorStackView.addArrangedSubview(indicatorDot) // Add the dot to the stack view
        }
        
        // Initially highlight the first dot
        updateIndicator(selectedIndex: 0)
    }

    // Create a single indicator dot
    func createIndicatorDot() -> UIView {
        let dot = UIView()
        dot.layer.cornerRadius = 4
        dot.backgroundColor = .lightGray // Inactive color
        dot.translatesAutoresizingMaskIntoConstraints = false
        dot.heightAnchor.constraint(equalToConstant: 8).isActive = true
        dot.widthAnchor.constraint(equalToConstant: 8).isActive = true
        return dot
    }

    // Update the indicator to highlight the active dot
    func updateIndicator(selectedIndex: Int) {
        for (index, dot) in indicatorViews.enumerated() {
            dot.backgroundColor = (index == selectedIndex) ? .darkGray : .lightGray // Active dot
        }
    }
    
    // Create rating stars for the rating section
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
}

// Carousel delegate method to update the indicator
//extension ProductDetailsViewController {
//    func updateIndicator(selectedIndex: Int) {
//        updateIndicator(selectedIndex: selectedIndex)
//    }
//}


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
