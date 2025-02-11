//
//  ViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 09/02/2025.
//

import UIKit
import Apollo
import MyAPI
class ViewController: UIViewController {

    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var names : [String] = ["youssab" , "yasser" , "youssef" , "ziad" , "mai" , "andrew" , "hellana" ,"mohsen" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initNib()
        initUI()

        // Assuming ApolloNetworkService is your Apollo client setup
        ApolloNetwokService.shared.apollo.fetch(query: MyQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                // Check for data
                if let data = graphQLResult.data {
                    // Access the products
                    let products = data.products.edges ?? [] // Provide a default empty array if `edges` is nil
                    for productEdge in products {
                        let product = productEdge.node // `node` is non-optional, so no need for `if let`
                        print("Product ID: \(product.id)")
                        print("Product Title: \(product.title)")

                        // Access the images
                        let images = product.images.edges ?? [] // Provide a default empty array if `edges` is nil
                        for imageEdge in images {
                            let image = imageEdge.node // `node` is non-optional, so no need for `if let`
                            print("Image URL: \(image.url)")
                            print("Image Dimensions: \(image.width)x\(image.height)")
                        }
                    }
                } else if let errors = graphQLResult.errors {
                    // Handle GraphQL errors
                    print("GraphQL Errors: \(errors)")
                }
            case .failure(let error):
                // Handle network or other errors
                print("Network Error: \(error)")
            }
        }
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



