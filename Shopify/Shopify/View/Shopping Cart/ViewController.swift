//
//  ViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 09/02/2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var names : [String] = ["youssab" , "yasser" , "youssef" , "ziad" , "mai" , "andrew" , "hellana" ,"mohsen" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initNib()
        initUI()
    }

    func initNib(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ShoppingCartTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    func initUI(){
        checkoutButton.layer.cornerRadius = checkoutButton.frame.height / 2
        checkoutButton.layer.cornerCurve = .continuous
        checkoutButton.clipsToBounds = true
    }
    
}

extension ViewController: UITableViewDelegate , UITableViewDataSource , ShoppingCartTableViewCellDelegate{
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShoppingCartTableViewCell
        cell.delegate = self
        cell.productName.text = names[indexPath.row]
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
            alert.addAction(UIAlertAction(title: "Cancle", style: .default, handler: {_ in }))
            self.present(alert, animated: true)
        }
    }
}



