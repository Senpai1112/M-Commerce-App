//
//  AddAddressViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 15/02/2025.
//

import UIKit
import Lottie

class AddAddressViewController: UIViewController {
    private var animationView : LottieAnimationView!
    private var addAddressViewModel = AddAddressViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var customerAccessToken : String?
    
    @IBOutlet weak var addAddressButton: UIButton!
    @IBOutlet weak var viewForMapAnimation: UIView!
    
    @IBOutlet weak var countryName: UITextField!
    
    @IBOutlet weak var cityName: UITextField!
    
    @IBOutlet weak var streetName: UITextField!
    
    @IBOutlet weak var apartmentNumber: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationView()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "ADD Addresses"
    }
    func setupAnimationView(){
        animationView = .init(name: "Location")
        animationView.frame = viewForMapAnimation.frame
        animationView.contentMode = .top
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        viewForMapAnimation.addSubview(animationView)
        animationView.play()
    }
    
    func initUI(){
        addAddressButton.layer.cornerRadius = addAddressButton.frame.height / 2
        addAddressButton.layer.cornerCurve = .continuous
        addAddressButton.clipsToBounds = true
        addAddressButton.tintColor = UIColor.purple

        
        countryName.borderStyle = .line
        phoneNumber.borderStyle = .line
        cityName.borderStyle = .line
        streetName.borderStyle = .line
        apartmentNumber.borderStyle = .line
        
        activityIndicator.color = .gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func addAddressButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "You have to fill all fields", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        if (countryName.text == "" || apartmentNumber.text == "" || cityName.text == "" || streetName.text == "" || phoneNumber.text == ""){
            self.present(alert, animated: true)
        }
        else{
            let address : Addresses = Addresses(country: countryName.text!, city: cityName.text!, address1 : streetName.text!, address2 : apartmentNumber.text!, phone: phoneNumber.text!)
            
            addAddressViewModel.bindErrorToAddAddressViewController = { [weak self] in
                self?.activityIndicator.stopAnimating()
                if  let error = self?.addAddressViewModel.addedAddressError.message{
                    let alert = UIAlertController(title: "Error adding address", message: "\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                    self!.present(alert, animated: true)
                }
            }
            addAddressViewModel.bindResultToAddAddressViewController = { [weak self] in
                self?.activityIndicator.stopAnimating()
                let alert = UIAlertController(title: "Address added succssfuly", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    self?.navigationController?.popViewController(animated: true)
                })
                self!.present(alert, animated: true)
            }
            addAddressViewModel.createAddressInModel(customerAccessToken: customerAccessToken, address: address)
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
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
