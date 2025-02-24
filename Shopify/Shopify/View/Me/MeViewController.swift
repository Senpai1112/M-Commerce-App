//
//  MeViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 18/02/2025.
//

import UIKit

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var moreOrders: UIButton!
    @IBOutlet weak var ordersTable: UITableView!

    var viewModel: OrdersViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTable.dataSource = self
        ordersTable.delegate = self
        initNib()
       
    }
    ///setupNavigationBarIcons
    override func viewWillAppear(_ animated: Bool) {
       self.tabBarController?.title = "Me"
        viewModel = OrdersViewModel()
        viewModel.bindOrdersToViewController = {
            DispatchQueue.main.async {
                self.ordersTable.reloadData()
            }}

        viewModel.getOrdersFromModel(token: UserDefaults.standard.string(forKey: "accessToken") ?? "" )

        setupNavigationBarIcons()
        if let token = UserDefaults.standard.string(forKey: "accessToken"), !token.isEmpty  {
                    removeLoginView()
                } else {
                    showLoginView()
                }
        
    }
    
    
    func initNib(){
        let nib = UINib(nibName: "OrderCell", bundle: nil)
        self.ordersTable.register(nib, forCellReuseIdentifier: "OrderCell")
            
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
        
        stackView.addArrangedSubview(settingsButt)
        stackView.addArrangedSubview(butt3)
        
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
    

    func setUpNavBarBtn(button: UIButton, systemName: String, selector: Selector) {
        if let icon = UIImage(systemName: systemName) {
            button.setImage(icon, for: .normal)
        }
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    /////count of orders
    var displayedOrders = 2
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(viewModel?.finalResult.count ?? 0, displayedOrders)
    }
    @IBAction func moreOrdersAction(_ sender: Any) {
        displayedOrders = viewModel.finalResult.count
            ordersTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        let order = viewModel.finalResult[indexPath.row]
        cell.orderDateLabel.text = "Created At: \(order.processedAt ?? "")"
        cell.orderPriceLabel.text = "Price: \(order.price ?? 0) \(order.currencyCode ?? "")"

        return cell
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60   }
   
    
    func showLoginView() {
            let loginView = UIView()
        loginView.tag = 100
            loginView.frame = view.bounds
            loginView.backgroundColor = .white
            
            let messageLabel = UILabel()
            messageLabel.text = "Please log in to view your profile."
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

func removeLoginView() {
          view.viewWithTag(100)?.removeFromSuperview()
          }
}
