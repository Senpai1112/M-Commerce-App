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
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.myFavTableView.reloadData()
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

        //
        
        
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
        
    }
   
  override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell") as! FavouritesTableViewCell
        
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.borderWidth = 1
        
        let product = wishList[indexPath.row]
        cell.setUpCell(photo: product.productImage ?? "" , name: product.productName ?? "", price: product.productPrice ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
