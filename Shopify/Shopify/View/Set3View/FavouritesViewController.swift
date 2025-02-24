//
//  FavouritesViewController.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 20/02/2025.
//

import UIKit

class FavouritesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myFavTableView: UITableView!
    var wishList = [FavoriteProduct]()
    var emptyStateView: UIView?

    
    override func viewWillAppear(_ animated: Bool) {
        self.myFavTableView.reloadData()
        
        initNib()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.checkIfTableEmty()

        }
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        title = "WishList"
        super.viewDidLoad()
        myFavTableView.delegate = self
        myFavTableView.dataSource = self
        myFavTableView.separatorStyle = .none
        emptyState() 

        //
        
        
    }
    func emptyState() {
        if let emptyStateView = emptyStateView {
                    emptyStateView.isHidden = true
                    view.addSubview(emptyStateView)
                    
                    emptyStateView.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                        emptyStateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
                        emptyStateView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
                    ])
                }
    }
    func updateEmptyState() {
            if wishList.isEmpty {
                emptyStateView?.isHidden = false
                myFavTableView.isHidden = true
            } else {
                emptyStateView?.isHidden = true
                myFavTableView.isHidden = false
            }
        }
    
    func initNib(){
        let nib = UINib(nibName: "FavouriteCell", bundle: nil)
        self.myFavTableView.register(nib, forCellReuseIdentifier: "FavouriteCell")
        let emptyStateNib = UINib(nibName: "favEmptyState", bundle: nil)
              emptyStateView = emptyStateNib.instantiate(withOwner: nil, options: nil).first as? UIView
        if let emptyStateView = emptyStateView {
                   view.addSubview(emptyStateView)
                   emptyStateView.isHidden = true
               }
            
        }
    func checkIfTableEmty(){
        if wishList.count == 0 {
            myFavTableView.isHidden = true
          //  placeholder.isHidden = false
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        wishList = CoreDataManager.fetchFromCoreData()
        myFavTableView.reloadData()
        updateEmptyState()

        
    }
   
  override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell") as! FavouriteCell
        
        
        let product = wishList[indexPath.row]
        cell.favTitle.text = product.productName
        if let price = product.productPrice {
            cell.favPrice.text = "\(price) "
        }
        if let imageURL = product.productImage, let url = URL(string: imageURL) {
            cell.favImage.kf.setImage(with: url, placeholder: UIImage(named: "1"))
        }

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            showAlert(indexPath: indexPath)
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Set3", bundle: nil)
        var detailsVC = storyboard.instantiateViewController(withIdentifier: "detailsVC") as! ProductDetailsViewController
        
        detailsVC.id = wishList[indexPath.row].productId
         
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }
    
    
    func showAlert(indexPath: IndexPath){
        // declare Alert
        let alert = UIAlertController(title: "Delete", message: "Are you sure about deletion?", preferredStyle: .alert)
        
        //AddAction
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [self] action in
            UserDefaults.standard.set(false, forKey: "\((wishList[indexPath.row].productId)!)")
            CoreDataManager.deleteFromCoreData(productId: wishList[indexPath.row].productId ?? "")
            wishList.remove(at: indexPath.row)
            myFavTableView.deleteRows(at: [indexPath], with: .fade)
            
            self.myFavTableView.reloadData()
            updateEmptyState()

            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel , handler: { action in
        }))
        

        //showAlert
        self.present(alert, animated: true) {
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
