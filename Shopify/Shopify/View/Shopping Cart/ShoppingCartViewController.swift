//
//  ViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 09/02/2025.
//

import UIKit
import Apollo
import MyApi

class ShoppingCartViewController: UIViewController {
    
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalPriceOfProducts: UILabel!
        
    var names : [String] = ["youssab" , "yasser" , "youssef" , "ziad" , "mai" , "andrew" , "hellana" ,"mohsen" ]
    
    var prices : [String] = ["100" , "200" , "300" , "400" , "500" , "600" , "700" ,"800" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initNib()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Shopping Cart"
    }
    
    func initNib(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ShoppingCartTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ShoppingCartTableViewCell")
    }
    func initUI(){
        checkoutButton.layer.cornerRadius = checkoutButton.frame.height / 2
        checkoutButton.layer.cornerCurve = .continuous
        checkoutButton.clipsToBounds = true
    }
    
    @IBAction func checkOutButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Set2", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "ChooseAddressViewController") as! ChooseAddressViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ShoppingCartViewController: UITableViewDelegate , UITableViewDataSource , ShoppingCartTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if names.count == 0 {
            return 0
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell", for: indexPath) as! ShoppingCartTableViewCell
        cell.delegate = self
        cell.productName.text = names[indexPath.row]
        cell.productPrice.text = prices[indexPath.row]
        cell.configure(with: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func removeCell(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Deleting", message: "Do you want to delete \(names[indexPath.row])", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive) { [self]_ in
            names.remove(at: indexPath.row)
            tableView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancle", style: .default, handler: {_ in }))
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Deleting", message: "Do you want to delete \(names[indexPath.row])", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive) { [self]_ in
                names.remove(at: indexPath.row)
                tableView.reloadData()
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in }))
            self.present(alert, animated: true)
        }
    }
}



