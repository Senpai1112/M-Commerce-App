//
//  MeViewController.swift
//  Shopify
//
//  Created by Mai Atef  on 18/02/2025.
//

import UIKit

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var ordersTable: UITableView!

    var viewModel: OrdersViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTable.dataSource = self
        ordersTable.delegate = self
        
        viewModel = OrdersViewModel()
        viewModel.bindOrdersToViewController = {
            DispatchQueue.main.async {
                self.ordersTable.reloadData()
            }}
       // viewModel.getOrdersFromModel(token: UserDefaults.standard.string(forKey: "accessToken" )! ) 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBarIcons()

            self.tabBarController?.title = "Me"
}
    
    func setupNavigationBarIcons() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        let settingsButt = UIButton(type: .system)
        setUpNavBarBtn(button: settingsButt, systemName: "gearshape", selector: #selector(settingsTapped))
        
        let butt2 = UIButton(type: .system)
        setUpNavBarBtn(button: butt2, systemName: "heart", selector: #selector(favTapped))
        
        let butt3 = UIButton(type: .system)
        setUpNavBarBtn(button: butt3, systemName: "cart", selector: #selector(cartTapped))
        
        
        stackView.addArrangedSubview(settingsButt)
        stackView.addArrangedSubview(butt2)
        stackView.addArrangedSubview(butt3)
        
        let barButtonItem = UIBarButtonItem(customView: stackView)
        tabBarController?.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func settingsTapped() {
        
        let storyBord = UIStoryboard(name: "Set2", bundle: nil)
        let settingsVc = storyBord.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
     
        navigationController?.pushViewController(settingsVc, animated: true)
    }
    
    @objc func favTapped() {
       print("favTapped")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.finalResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        let order = viewModel.finalResult[indexPath.row]
           cell.textLabel?.text = "Price: \(order.price) \(order.currencyCode)"
           cell.detailTextLabel?.text = "CreatedAt: \(order.processedAt)"
        return cell
    }
}
