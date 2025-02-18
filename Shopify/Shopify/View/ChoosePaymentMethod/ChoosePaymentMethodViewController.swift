//
//  ChoosePaymentMethodViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 17/02/2025.
//

import UIKit
import PassKit

class ChoosePaymentMethodViewController: UIViewController {

    @IBOutlet weak var continueToPayment: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var address = Addresses()
    var selectedIndex: IndexPath?
    var headersForSections : [String] = ["Online Payment","More Payment Options"]
    var titlesForRow : [String] = [" Apple Pay","Cash On Delivery (COD)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(address.city!)
        initNib()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Payment Options"
    }
    
    @IBAction func continueToPayment(_ sender: UIButton) {
        if selectedIndex == nil{
            let alert = UIAlertController(title: "Please Choose Payment Method", message:"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive) { _ in})
            self.present(alert, animated: true)
        }
        else{
            
        }
    }
    func initNib(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ChoosePaymentMethodTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ChoosePaymentMethodTableViewCell")
    }
    func initUI(){
        continueToPayment.layer.cornerRadius = continueToPayment.frame.height / 2
        continueToPayment.layer.cornerCurve = .continuous
        continueToPayment.clipsToBounds = true
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
extension ChoosePaymentMethodViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return headersForSections[section]
        default:
            return headersForSections[section]
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoosePaymentMethodTableViewCell", for: indexPath) as! ChoosePaymentMethodTableViewCell
        configureCell(cell, at: indexPath)
        return cell
    }
    
    
    func configureCell(_ cell: ChoosePaymentMethodTableViewCell, at indexPath: IndexPath) {
        
        cell.selectionStyle = .none
        
        cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        cell.checkButton.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
        
        cell.paymentMethodLabel.text = titlesForRow[indexPath.section]
        
        if selectedIndex == indexPath {
            cell.checkButton.isSelected = true
        } else {
            cell.checkButton.isSelected = false
        }
        
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
