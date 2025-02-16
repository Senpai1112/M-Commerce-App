//
//  AddressesDetailsViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 15/02/2025.
//

import UIKit

class AddressesDetailsViewController: UIViewController {
    
    private var addressViewModel = AddressesViewModel()
    @IBOutlet weak var addNewAddress: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNib()
        initUI()
        
        addressViewModel.bindResultToAddressDetailsTableViewController = { () in
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
            }
        }
        addressViewModel.getAddressesFromModel()
        // Do any additional setup after loading the view.
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
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if addressViewModel.finalResult.count == 0{
            return 0
        }else{
            return addressViewModel.finalResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressesDetailsTableViewCell", for: indexPath) as! AddressesDetailsTableViewCell
        cell.cityAndAdressDetails.text = addressViewModel.finalResult[indexPath.row].title
        cell.phoneNumber.text = addressViewModel.finalResult    [indexPath.row].id
        cell.backgroundColor = .systemGray6
        cell.layer.borderColor = UIColor.systemBackground.cgColor
        cell.layer.borderWidth = 10
        cell.clipsToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
