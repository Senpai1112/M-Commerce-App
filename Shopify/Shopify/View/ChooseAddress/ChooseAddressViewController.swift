//
//  ChooseAddressViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 17/02/2025.
//

import UIKit

class ChooseAddressViewController: UIViewController {
    
    private var addressDetailsViewModel = AddressDetailsViewModel()
    var customerAccessToken : String = "fc1bea2489ae90f294f2c8795e0dd7ff"
    var backgroundImageView: UIImageView?

    var selectedIndex: IndexPath?
    @IBOutlet weak var continueToPayment: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNib()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Choose Address"
        addressDetailsViewModel.bindResultToAddressDetailsTableViewController = { () in
            DispatchQueue.main.async { [weak self] in
                if self?.addressDetailsViewModel.addressResult.count == 0{
                    self?.addBackgroundImage(named: "noLocation")
                }else{
                    self?.removeBackgroundImage()
                }
                self?.tableView.reloadData()
            }
        }
        addressDetailsViewModel.getAddressesFromModel(customerAccessToken: customerAccessToken)
    }
    
    func addBackgroundImage(named imageName: String) {
        let imageView = UIImageView(frame: CGRect(x:70 , y: 130, width: 250, height: 500))
           imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
           imageView.tag = 100  // Assign a tag to easily remove later
        self.tableView.addSubview(imageView)
        self.tableView.sendSubviewToBack(imageView)  // Ensure it stays at the back
           backgroundImageView = imageView
       }
    
    func removeBackgroundImage() {
        if let imageView = self.tableView.viewWithTag(100) {
            imageView.removeFromSuperview()
        }
    }
    
    func initNib(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ChooseAddressTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ChooseAddressTableViewCell")
    }
    func initUI(){
        continueToPayment.layer.cornerRadius = continueToPayment.frame.height / 2
        continueToPayment.layer.cornerCurve = .continuous
        continueToPayment.clipsToBounds = true
        continueToPayment.tintColor = UIColor.purple

    }

    @IBAction func continueToPayment(_ sender: UIButton) {
        if selectedIndex == nil{
            let alert = UIAlertController(title: "Please Select an address", message:"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive) { _ in})
            self.present(alert, animated: true)
        }else{
            let storyBoard = UIStoryboard(name: "Set2", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CartSummaryViewController") as! CartSummaryViewController
            vc.address = addressDetailsViewModel.addressResult[selectedIndex!.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
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

extension ChooseAddressViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressDetailsViewModel.addressResult.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseAddressTableViewCell", for: indexPath) as! ChooseAddressTableViewCell
        configureCell(cell, at: indexPath)
        return cell
    }
    
    func configureCell(_ cell: ChooseAddressTableViewCell, at indexPath: IndexPath) {
        
        cell.selectionStyle = .none
        
        cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        cell.checkButton.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
        
        if selectedIndex == indexPath {
            cell.checkButton.isSelected = true
        } else {
            cell.checkButton.isSelected = false
        }
        
        cell.cityName.text = addressDetailsViewModel.addressResult[indexPath.row].city
        cell.phoneNumber.text = addressDetailsViewModel.addressResult[indexPath.row].phone
        cell.countryName.text = addressDetailsViewModel.addressResult[indexPath.row].country
        cell.backgroundColor = .systemGray6
        cell.layer.borderColor = UIColor.systemBackground.cgColor
        cell.layer.borderWidth = 10
        cell.clipsToBounds = true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedIndex = indexPath
            tableView.reloadData()
    }
}
