//
//  MeViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 18/02/2025.
//

import UIKit

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var moreOrders: UIButton!
    @IBOutlet weak var ordersTable: UITableView!
    @IBOutlet weak var wishListTableView: UITableView!
    var wishList = [FavoriteProduct]()
    
    var viewModel: OrdersViewModel!
    
    var ordersActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTable.dataSource = self
        ordersTable.delegate = self
        
        wishListTableView.dataSource = self
        wishListTableView.delegate = self
        setupActivityIndicators()

        initNib()
       
    }
    ///setupNavigationBarIcons
    override func viewWillAppear(_ animated: Bool) {
        setupLeftBarButt()
        welcomeLabel.text = "Welcome, \(UserDefaults.standard.string(forKey: "customerFirstName") ?? "")"
        wishList = CoreDataManager.fetchFromCoreData()
        viewModel = OrdersViewModel()
        viewModel.bindOrdersToViewController = {
            DispatchQueue.main.async {
                self.ordersActivityIndicator.stopAnimating()
                self.ordersTable.reloadData()
                self.wishListTableView.reloadData()
            }}
        ordersActivityIndicator.startAnimating()
        
        viewModel.getOrdersFromModel(token: UserDefaults.standard.string(forKey: "accessToken") ?? "" )

        setupNavigationBarIcons()
        if let token = UserDefaults.standard.string(forKey: "accessToken"), !token.isEmpty  {
                    removeLoginView()
                } else {
                    showLoginView()
                }
        
    }
    func setupActivityIndicators() {
          ordersActivityIndicator = UIActivityIndicatorView(style: .large)
          ordersActivityIndicator.center = ordersTable.center
          ordersActivityIndicator.hidesWhenStopped = true
          view.addSubview(ordersActivityIndicator)
        
      }
    
    func initNib(){
        let nib = UINib(nibName: "OrderCell", bundle: nil)
        self.ordersTable.register(nib, forCellReuseIdentifier: "OrderCell")
        let nib2 = UINib(nibName: "FavouriteCell", bundle: nil)
        self.wishListTableView.register(nib2, forCellReuseIdentifier: "FavouriteCell")
        }
   
    func setupNavigationBarIcons() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        
        let settingsButt = UIButton(type: .system)
        setUpNavBarBtn(button: settingsButt, systemName: "gearshape", selector: #selector(settingsTapped))
        
               
        let butt3 = UIButton(type: .system)
        setUpNavBarBtn(button: butt3, systemName: "cart", selector: #selector(cartTapped))
        stackView.addArrangedSubview(butt3)
        stackView.addArrangedSubview(settingsButt)
        
        let barButtonItem = UIBarButtonItem(customView: stackView)
        tabBarController?.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    
    
    
    @objc func settingsTapped() {
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken"), !accessToken.isEmpty {
            let storyBord = UIStoryboard(name: "Set2", bundle: nil)
            let settingsVc = storyBord.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            navigationController?.pushViewController(settingsVc, animated: true)
        } else {
            showLoginAlert()
        }
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


    func showLoginAlert() {
        let alert = UIAlertController(title: "Login Required", message: "Please log in to access this page.", preferredStyle: .alert)
        let loginAction = UIAlertAction(title: "Log In", style: .default) { _ in
            let storyBord = UIStoryboard(name: "Set3", bundle: nil)
            let loginVC = storyBord.instantiateViewController(withIdentifier: "loginVC") as! LoginCustomerViewController
            self.navigationController?.pushViewController(loginVC, animated: true)        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    

    func setUpNavBarBtn(button: UIButton, systemName: String, selector: Selector) {
        if let icon = UIImage(systemName: systemName) {
            button.setImage(icon, for: .normal)
        }
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.ordersTable {
            let count = min(2, viewModel?.finalResult.count ?? 0)
            if count == 0 {
                        showEmptyMessage(tableView, message: "No orders yet.")
                        self.ordersActivityIndicator.stopAnimating()
                    }
                    return count

        }else {
            let count = min(4, wishList.count)
                  if count == 0 { showEmptyMessage(tableView, message: "No favorites yet.") }
                  return count        }
    }
    func showEmptyMessage(_ tableView: UITableView, message: String) {
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        messageLabel.frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height)
        
        tableView.backgroundView = messageLabel
        tableView.separatorStyle = .none
    }

    @IBAction func moreOrdersAction(_ sender: Any) {
        let storyBord = UIStoryboard(name: "Set-1", bundle: nil)
        let ordersTableVC = storyBord.instantiateViewController(withIdentifier: "ordersTableVC") as! OrdersTableViewController
        ordersTableVC.orders = viewModel.finalResult
        navigationController?.pushViewController(ordersTableVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.backgroundView = nil
        tableView.separatorStyle = .singleLine
        if tableView == self.ordersTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
            let order = viewModel.finalResult[indexPath.row]
            cell.orderDateLabel.text = "Created At: \(order.processedAt?.formattedDate() ?? " ")"
            cell.orderPriceLabel.text = "Price: \(order.price ?? 0) \(order.currencyCode ?? "")"

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteCell
            let product = wishList[indexPath.row]
            cell.favTitle.text = product.productName
            if let price = product.productPrice {
                cell.favPrice.text = " \(mapCost(amount: price, currencyCode: UserDefaults.standard.string(forKey: "currencyCode") ?? "EGP") ?? 0.0) \(UserDefaults.standard.string(forKey: "currencyCode") ?? "")"
            }
            if let imageURL = product.productImage, let url = URL(string: imageURL) {
                cell.favImage.kf.setImage(with: url, placeholder: UIImage(named: "1"))
            }

            return cell
            
        }
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.ordersTable {
            return 60
        }else{
            return 90
            }
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.ordersTable {
            let order = viewModel.finalResult[indexPath.row]
           let storyBord = UIStoryboard(name: "Set-1", bundle: nil)

            let detailsVC = storyBord.instantiateViewController(withIdentifier: "orderInfoVC") as! OrderDetailsViewController
            detailsVC.order = order
            navigationController?.pushViewController(detailsVC, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Set3", bundle: nil)
            var detailsVC = storyboard.instantiateViewController(withIdentifier: "detailsVC") as! ProductDetailsViewController
            
            detailsVC.id = wishList[indexPath.row].productId
             
            
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
        
     }
 
    func showLoginView() {
            let loginView = UIView()
        loginView.tag = 100
            loginView.frame = view.bounds
            loginView.backgroundColor = .white
            
            let messageLabel = UILabel()
            messageLabel.text = "Log in to access and manage your account"
            messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        messageLabel.textColor = .lightGray
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let loginButton = UIButton(type: .system)
            loginButton.setTitle("Log In", for: .normal)
            loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
            loginButton.backgroundColor = .purple
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.layer.cornerRadius = 8
            loginButton.translatesAutoresizingMaskIntoConstraints = false
            
            loginView.addSubview(messageLabel)
            loginView.addSubview(loginButton)
            view.addSubview(loginView)
            
            NSLayoutConstraint.activate([
                messageLabel.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
                messageLabel.centerYAnchor.constraint(equalTo: loginView.centerYAnchor, constant: -20),
                loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
                loginButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
                loginButton.widthAnchor.constraint(equalToConstant: 120),
                loginButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
      
      @objc func loginTapped() {
          let storyBord = UIStoryboard(name: "Set3", bundle: nil)
          let loginVC = storyBord.instantiateViewController(withIdentifier: "loginVC") as! LoginCustomerViewController
          navigationController?.pushViewController(loginVC, animated: true)
      }

    @IBAction func showAllFavourites(_ sender: Any) {
        let storyBord = UIStoryboard(name: "Set3", bundle: nil)
        let favoriteVC = storyBord.instantiateViewController(withIdentifier: "favouritesVC") as! FavouritesViewController
        navigationController?.pushViewController(favoriteVC, animated: true)
        
    }
    func removeLoginView() {
          view.viewWithTag(100)?.removeFromSuperview()
          }

        func setupLeftBarButt() {
            let titleLabel = UILabel()
                titleLabel.text = " "
                let barButtonItem = UIBarButtonItem(customView: titleLabel)
                self.tabBarController?.navigationItem.leftBarButtonItem = barButtonItem
        }
    func mapCost(amount: String?, currencyCode: String?) -> Double? {
            guard let amount = amount else { return nil }
            let doubleCost = (Double(amount) ?? 0.0) * UserDefaults.standard.double(forKey: "currencyValue")
            let formattedPrice = (doubleCost * 100).rounded() / 100
            return formattedPrice
        }
}
