//
//  AddressesDetailsViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 15/02/2025.
//

import UIKit

class AddressesDetailsViewController: UIViewController {
    
    private let addressDetailsViewModel = AddressDetailsViewModel()
    var customerAccessToken : String = "11bf21615f5e2b40a877bdbeb51f8116"
    @IBOutlet weak var addNewAddress: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNib()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addressDetailsViewModel.bindResultToAddressDetailsTableViewController = { () in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        addressDetailsViewModel.getAddressesFromModel(customerAccessToken: customerAccessToken)
    }
    
    func initNib(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "AddressesDetailsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "AddressesDetailsTableViewCell")
    }
    func initUI(){
        addNewAddress.layer.cornerRadius = addNewAddress.frame.height / 2
        addNewAddress.layer.cornerCurve = .continuous
        addNewAddress.clipsToBounds = true
    }
    
    @IBAction func addNewAddress(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Set2", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        viewController.customerAccessToken = customerAccessToken
        self.navigationController?.pushViewController(viewController, animated: true)
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

extension AddressesDetailsViewController:
    UITableViewDelegate,UITableViewDataSource {
    
    func configureCell(_ cell: AddressesDetailsTableViewCell, at indexPath: IndexPath) {
        cell.cityAndAdressDetails.text = addressDetailsViewModel.addressResult[indexPath.row].city
        cell.phoneNumber.text = addressDetailsViewModel.addressResult[indexPath.row].phone
        cell.countryName.text = addressDetailsViewModel.addressResult[indexPath.row].country
        cell.backgroundColor = .systemGray6
        cell.layer.borderColor = UIColor.systemBackground.cgColor
        cell.layer.borderWidth = 10
        cell.clipsToBounds = true
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if addressDetailsViewModel.addressResult == nil {
            return 0
        }else{
            return addressDetailsViewModel.addressResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressesDetailsTableViewCell", for: indexPath) as! AddressesDetailsTableViewCell
        configureCell(cell, at: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Deleting", message: "Do you want to delete This Address?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive) { [self] _ in
                addressDetailsViewModel.deleteAddressesFromModel(customerAccessToken: customerAccessToken, addressId: addressDetailsViewModel.addressResult[indexPath.row].id , indexPath: indexPath)
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in }))
            self.present(alert, animated: true)
        }
    }
    
}
