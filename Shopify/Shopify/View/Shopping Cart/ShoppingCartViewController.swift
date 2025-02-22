//
//  ViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 09/02/2025.
//

import UIKit
import Apollo
import MyApi
import SDWebImage

class ShoppingCartViewController: UIViewController {
    
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalPriceOfProducts: UILabel!
    
    @IBOutlet weak var currencyCode: UILabel!
    var cartCount = 0
    var backgroundImageView: UIImageView?
    
    private let cartViewModel = CartViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var cartId : String {
        return UserDefaults.standard.string(forKey: "cartID") ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initNib()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Shopping Cart"
        self.cartViewModel.bindResultToShoppingCartTableViewController = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if self.cartViewModel.localCartResult.cart?.count == 0{
                    self.addBackgroundImage(named: "emptyCart")
                }else{
                    self.removeBackgroundImage()
                }
                self.cartCount = self.cartViewModel.localCartResult.cart?.count ?? 0
                self.activityIndicator.stopAnimating()
                self.totalPriceOfProducts.text = "\(self.cartViewModel.localCartResult.totalCost?.subtotalAmount?.amount ?? "0")"
                self.currencyCode.text = "\(self.cartViewModel.localCartResult.totalCost?.subtotalAmount?.currencyCode ?? "US")"
                self.tableView.reloadData()
            }
        }
        cartViewModel.getCartFromModel(cartID: cartId)
    }
    
    func addBackgroundImage(named imageName: String) {
        if backgroundImageView == nil {
            let imageView = UIImageView(frame: CGRect(x:70 , y: 130, width: 250, height: 500))
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .scaleAspectFit
            imageView.tag = 100  // Assign a tag to easily remove later
            self.tableView.addSubview(imageView)
            self.tableView.sendSubviewToBack(imageView)  // Ensure it stays at the back
            backgroundImageView = imageView
        }
    }
    
    func removeBackgroundImage() {
        backgroundImageView?.removeFromSuperview()
        backgroundImageView = nil
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
        checkoutButton.tintColor = UIColor.purple
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    @IBAction func checkOutButton(_ sender: Any) {
        if cartViewModel.localCartResult.cart == nil || cartViewModel.localCartResult.cart?.count == 0{
            let alert = UIAlertController(title: "Nothing in the Cart To Chekout", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in }))
            self.present(alert, animated: true)
        }else{
            let storyBoard = UIStoryboard(name: "Set2", bundle: nil)
            let vc = storyBoard.instantiateViewController(identifier: "ChooseAddressViewController") as! ChooseAddressViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ShoppingCartViewController: UITableViewDelegate , UITableViewDataSource , ShoppingCartTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartTableViewCell", for: indexPath) as! ShoppingCartTableViewCell
        var quantaty : Int = 0
        cell.cartViewModel = self.cartViewModel
        cell.delegate = self
        if let item = self.cartViewModel.localCartResult.cart?[indexPath.row] {
            cell.productName.text = item.merchandise?.productTitle
            cell.productDetails.text = item.merchandise?.title
            cell.productPrice.text = "\(item.cost?.checkoutChargeAmount?.amount ?? "0")"
            cell.currencyCode.text = "\(item.cost?.checkoutChargeAmount?.currencyCode ?? "USD")"
            quantaty = item.quantity!
            cell.productQuantaty.text = item.quantity?.codingKey.stringValue
            if let urlStr = item.merchandise?.image, let url = URL(string: urlStr) {
                cell.productImage.sd_setImage(with: url, placeholderImage: UIImage(named: "Ad"))
            }
        }
        cell.configure(with: indexPath , quantity: quantaty)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func removeCell(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "Deleting", message: "Do you want to delete \(self.cartViewModel.localCartResult.cart?[indexPath.row].merchandise?.productTitle ?? "")", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive) { [self] _ in
            
            let lineId = [self.cartViewModel.localCartResult.cart?[indexPath.row].id ?? ""]
            self.cartViewModel.deleteCartInModel(cartID: cartId, lineID: lineId, indexPath: indexPath)
        })
        alert.addAction(UIAlertAction(title: "Cancle", style: .default, handler: {_ in }))
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Deleting", message: "Do you want to delete \(self.cartViewModel.localCartResult.cart?[indexPath.row].merchandise?.productTitle ?? "")", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive) { [self]_ in
                let lineId = [self.cartViewModel.localCartResult.cart?[indexPath.row].id ?? ""]
                self.cartViewModel.deleteCartInModel(cartID: cartId, lineID: lineId, indexPath: indexPath)
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in }))
            self.present(alert, animated: true)
        }
    }
    
    func quantityDidChange(for indexPath: IndexPath, newQuantity: Int) {
        cartViewModel.localCartResult.cart?[indexPath.row].quantity = newQuantity
        cartViewModel.updateCartInModel(
            cartID: cartViewModel.localCartResult.id,
            lineQuantuty: newQuantity,
            lineID: cartViewModel.localCartResult.cart?[indexPath.row].id,
            merchandiseId: cartViewModel.localCartResult.cart?[indexPath.row].merchandise?.id
        )
        recalcTotalPrice()
    }
    
    private func recalcTotalPrice() {
        var overallTotal: Double = 0.0
        for item in cartViewModel.localCartResult.cart ?? [] {
            if let unitPriceStr = item.cost?.checkoutChargeAmount?.amount,
               let unitPrice = Double(unitPriceStr),
               let qty = item.quantity {
                overallTotal += unitPrice * Double(qty)
            }
        }
        totalPriceOfProducts.text = String(format: "%.2f", overallTotal)
    }
}



