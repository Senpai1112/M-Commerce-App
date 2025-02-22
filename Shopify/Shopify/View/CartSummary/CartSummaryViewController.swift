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
import Combine

class CartSummaryViewController: UIViewController {
    
    var address = Addresses()
    
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var validationLabel: UILabel!
    var discoundCopons = ["SUMMER30","WINTER30"]
    @IBOutlet weak var continueToPayment: UIButton!
    
    @IBOutlet weak var totalPriceOfProducts: UILabel!
    private let cartViewModel = CartViewModel()
    private var cancellable: AnyCancellable?

    let activityIndicator = UIActivityIndicatorView(style: .large)
/*
    var cartId: String {
        return UserDefaults.standard.string(forKey: "cartId") ?? ""
    }
*/
    var cartId : String = "gid://shopify/Cart/Z2NwLWV1cm9wZS13ZXN0MTowMUpNRVg5SjkzQk1DTjExNjNLUUNGTVdRWg?key=c4a1a467f54521f9a8e6ccaf6f3a584b"
    
    var newPrice = ""

    @IBOutlet weak var discoundCopon: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNib()
        initUI()
        setupTextFieldPublisher()
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
                self.newPrice = self.cartViewModel.localCartResult.totalCost?.subtotalAmount?.amount ?? "0.0"

                self.tableView.reloadData()
            }
        }
        cartViewModel.getCartFromModel(cartID: cartId)
    }
    
    private func setupTextFieldPublisher() {
        let publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: discoundCopon)
            
            cancellable = publisher
                .map { ($0.object as? UITextField)?.text ?? "" }
                .sink { [weak self] newText in
                    if newText == self?.discoundCopons[0]{
                        self?.validationLabel.text = "Valid"
                        self?.validationLabel.textColor = UIColor.red
                        self?.performDiscount()
                    }else if newText == self?.discoundCopons[1]{
                        self?.validationLabel.text = "Valid"
                        self?.validationLabel.textColor = UIColor.red
                        self?.performDiscount()
                    }else{
                        self?.validationLabel.text = "Not Valid"
                        self?.discount.text = "No Discount"
                        self?.validationLabel.textColor = UIColor.black
                        self?.newPrice = (self?.cartViewModel.localCartResult.totalCost?.subtotalAmount?.amount)!
                        self?.totalPriceOfProducts.text = self?.newPrice
                    }
                }
        }
    deinit {
            cancellable?.cancel()
        }
    func performDiscount(){
        let floatPrice = Float(totalPriceOfProducts.text ?? "0.0")
        let discountPrice = floatPrice! * 70 / 100
        let discountAmount = floatPrice! * 30 / 100
        let newDiscount = "\(discountAmount)"
        discount.text = newDiscount
        newPrice = "\(discountPrice)"
        totalPriceOfProducts.text = newPrice
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
        vc.newPrice = newPrice
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CartSummaryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartViewModel.localCartResult.cart?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartSummaryTableViewCell", for: indexPath) as! CartSummaryTableViewCell
        guard let cartItem = cartViewModel.localCartResult.cart?[indexPath.row] else {
                return cell
            }
            
            cell.productName.text = cartItem.merchandise?.productTitle ?? "Unknown Product"
            cell.productPrice.text = cartItem.cost?.totalAmount?.amount ?? "0.00"
            cell.productDetails.text = cartItem.merchandise?.title ?? "No details available"
            cell.productQuantaty.text = "\(cartItem.quantity ?? 0)"
            
            if let urlStr = cartItem.merchandise?.image, let url = URL(string: urlStr) {
                cell.productImage.sd_setImage(with: url, placeholderImage: UIImage(named: "1"))
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    
}

