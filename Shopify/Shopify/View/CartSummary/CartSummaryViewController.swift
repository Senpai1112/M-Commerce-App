//
//  CartSummaryViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 20/02/2025.
//

import UIKit
import Apollo
import MyApi
import SDWebImage

class CartSummaryViewController: UIViewController {
    
    var address = Addresses()
    
    @IBOutlet weak var continueToPayment: UIButton!
    
    @IBOutlet weak var totalPriceOfProducts: UILabel!
    private let cartViewModel = CartViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var cartId : String = "gid://shopify/Cart/Z2NwLWV1cm9wZS13ZXN0MTowMUpNRVg5SjkzQk1DTjExNjNLUUNGTVdRWg?key=c4a1a467f54521f9a8e6ccaf6f3a584b"
    
    var newPrice = ""

    @IBOutlet weak var discoundCopon: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNib()
        initUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Shopping Cart Summary"
        self.cartViewModel.bindResultToShoppingCartTableViewController = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.activityIndicator.stopAnimating()
                self.totalPriceOfProducts.text = self.cartViewModel.localCartResult.totalCost?.subtotalAmount?.amount
                self.newPrice = (self.cartViewModel.localCartResult.totalCost?.subtotalAmount?.amount)!
                self.tableView.reloadData()
            }
        }
        cartViewModel.getCartFromModel(cartID: cartId)
    }
    func initNib(){
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "CartSummaryTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CartSummaryTableViewCell")
    }
    func initUI(){
        continueToPayment.layer.cornerRadius = continueToPayment.frame.height / 2
        continueToPayment.layer.cornerCurve = .continuous
        continueToPayment.clipsToBounds = true
        continueToPayment.tintColor = UIColor.purple
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }

    @IBAction func continueToPayment(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Set2", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ChoosePaymentMethodViewController") as! ChoosePaymentMethodViewController
        vc.address = address
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CartSummaryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartViewModel.localCartResult.cart?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartSummaryTableViewCell", for: indexPath) as! CartSummaryTableViewCell
        cell.productName.text = cartViewModel.localCartResult.cart![indexPath.row].merchandise?.productTitle
        
        cell.productPrice.text = cartViewModel.localCartResult.cart![indexPath.row].cost?.totalAmount?.amount
        
        cell.productDetails.text = cartViewModel.localCartResult.cart![indexPath.row].merchandise?.title
        
        cell.productQuantaty.text = "\(cartViewModel.localCartResult.cart![indexPath.row].quantity ?? 0)"
        if let urlStr = cartViewModel.cartResult.cart![indexPath.row].merchandise?.image, let url = URL(string: urlStr) {
            cell.productImage.sd_setImage(with: url, placeholderImage: UIImage(named: "Ad"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    
}

