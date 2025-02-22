//
//  SettingsViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 13/02/2025.
//

import UIKit

class SettingsViewController: UIViewController {

    var customerAccessToken: String {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    var addressDetailsViewModel = AddressDetailsViewModel()
    var currencyViewModel = CurrencyViewModel()
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let titles = ["Address" , "Currency" , "Contact Us","About Us"]
    var details = ["address" , UserDefaults.standard.string(forKey: "currencyCode") ,"",""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNib()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Settings"
        details[0] = "Address"
        addressDetailsViewModel.bindResultToSettingTableViewController = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                if self?.addressDetailsViewModel.defaultAddressResult.city == ""
                {
                    self?.details[0] = "Address"
                }else{
                    self?.details[0] = (self?.addressDetailsViewModel.defaultAddressResult.city)!
                }
                self?.tableView.reloadData()
            }
        }
        currencyViewModel.bindResultToViewController = {}
        tableView.reloadData()
        addressDetailsViewModel.getDefaultAddressesFromModel(customerAccessToken: customerAccessToken)
        currencyViewModel.fetchCurrencyFromModel()
    }
    func initNib(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        let nib = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SettingsTableViewCell")
    }
    func initUI(){
        logoutButton.layer.cornerRadius = logoutButton.frame.height / 2
        logoutButton.layer.cornerCurve = .continuous
        logoutButton.clipsToBounds = true
        logoutButton.tintColor = UIColor.purple

    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SettingsViewController : UITableViewDataSource ,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        cell.detailsLabel.text = details[indexPath.row]
        cell.titleLabel.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let storyBoard = UIStoryboard(name: "Set2", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "AddressesDetailsViewController") as! AddressesDetailsViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        case 1:
            currencySetter()
        case 2:
            let storyBoard = UIStoryboard(name: "Set2", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            viewController.isAboutUs = false
            self.navigationController?.present(viewController, animated: true)
        default:
            let storyBoard = UIStoryboard(name: "Set2", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            viewController.isAboutUs = true
            self.navigationController?.present(viewController, animated: true)
            break
        }
        
    }
    
    func currencySetter(){
        let alert = UIAlertController(title: "Choose you Currency", message: "", preferredStyle: .alert)
        let egp = UIAlertAction(title: "EGP", style: .default, handler: {  _ in
            self.details[1] = "EGP"
            UserDefaults.standard.set("EGP", forKey: "currencyCode")
            UserDefaults.standard.set(1.0, forKey: "currencyValue")
            self.tableView.reloadData()
        })
        let usd = UIAlertAction(title: "USD", style: .default, handler: { _ in
            self.details[1] = "USD"
            UserDefaults.standard.set("USD", forKey: "currencyCode")
            guard let currencyValue = self.currencyViewModel.currencyResult.data else {return}
            for currency in currencyValue{
                if currency.key == "USD"{
                    guard let currencyValue = currency.value.value else { return }
                    UserDefaults.standard.set(currencyValue, forKey: "currencyValue")
                    print(currencyValue)
                }
            }
            self.tableView.reloadData()
        })
        alert.addAction(egp)
        alert.addAction(usd)
        self.present(alert, animated: true, completion: nil)
    }
    
}
