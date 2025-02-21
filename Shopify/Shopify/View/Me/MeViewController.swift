//
//  MeViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 18/02/2025.
//

import UIKit

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var moreOrders: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var ordersTable: UITableView!

    var viewModel: OrdersViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTable.dataSource = self
        ordersTable.delegate = self
        initNib()
        viewModel = OrdersViewModel()
        viewModel.bindOrdersToViewController = {
            DispatchQueue.main.async {
                self.ordersTable.reloadData()
            }}
        viewModel.getOrdersFromModel(token: UserDefaults.standard.string(forKey: "accessToken") ?? "" )
    }
    ///setupNavigationBarIcons
    override func viewWillAppear(_ animated: Bool) {
       self.tabBarController?.title = "Me"
        setupNavigationBarIcons()

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
        
        let storyBord = UIStoryboard(name: "Set2", bundle: nil)
        let settingsVc = storyBord.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
     
        navigationController?.pushViewController(settingsVc, animated: true)
    }
    
   
    
    @objc func cartTapped() {
        let storyBord = UIStoryboard(name: "Set2", bundle: nil)
        let cartVc = storyBord.instantiateViewController(withIdentifier: "ShoppingCartViewController") as! ShoppingCartViewController
     
        navigationController?.pushViewController(cartVc, animated: true)    }
    
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
        return min(viewModel.finalResult.count, displayedOrders)
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
    
    @IBAction func loginAction(_ sender: Any) {
        let storyBord = UIStoryboard(name: "Set3", bundle: nil)
        let loginVC = storyBord.instantiateViewController(withIdentifier: "loginVC") as! LoginCustomerViewController
       
        navigationController?.pushViewController(loginVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60   }
}
