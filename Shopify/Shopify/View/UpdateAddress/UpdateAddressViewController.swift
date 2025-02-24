//
//  UpdateAddressViewController.swift
//  Shopify
//
//  Created by Yasser Yasser on 21/02/2025.
//

import UIKit
import Lottie

class UpdateAddressViewController: UIViewController {

    private var animationView : LottieAnimationView!
    private var updateAddressViewModel = UpdateAddressViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var address : Addresses?
    var customerAccessToken: String {
        return UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }
    
    @IBOutlet weak var updateAddressButton: UIButton!
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
        self.navigationItem.title = "Update Addresses"
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
        updateAddressButton.layer.cornerRadius = updateAddressButton.frame.height / 2
        updateAddressButton.layer.cornerCurve = .continuous
        updateAddressButton.clipsToBounds = true
        updateAddressButton.tintColor = UIColor.purple

        
        countryName.borderStyle = .roundedRect
        phoneNumber.borderStyle = .roundedRect
        cityName.borderStyle = .roundedRect
        streetName.borderStyle = .roundedRect
        apartmentNumber.borderStyle = .roundedRect
        
        activityIndicator.color = .gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        
        countryName.text = address?.country
        cityName.text = address?.city
        streetName.text = address?.address1
        apartmentNumber.text = address?.address2
        phoneNumber.text = address?.phone
    }
    
    
    @IBAction func updateAddressButton(_ sender: Any) {
        let alert = UIAlertController(title: "You have to fill all fields", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        if (countryName.text == "" || apartmentNumber.text == "" || cityName.text == "" || streetName.text == "" || phoneNumber.text == ""){
            self.present(alert, animated: true)
        }
        else{
            if customerAccessToken == ""  {
                print("Access Token is invalid")
                return
            }

            let address : Addresses = Addresses(country: countryName.text!, city: cityName.text!, address1 : streetName.text!, address2 : apartmentNumber.text!, phone: phoneNumber.text!, id : address?.id)
            print(address)
            updateAddressViewModel.bindErrorToUpdateAddressViewController = { [weak self] in
                self?.activityIndicator.stopAnimating()
                if  let error = self?.updateAddressViewModel.updatedAddressError.message{
                    let alert = UIAlertController(title: "Error updating address", message: "\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                    self!.present(alert, animated: true)
                }
            }
            updateAddressViewModel.bindResultToUpdateAddressViewController = { [weak self] in
                self?.activityIndicator.stopAnimating()
                let alert = UIAlertController(title: "Address Updated succssfuly", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    print(self?.updateAddressViewModel.updatedAddressResult ?? "")
                    self?.navigationController?.popViewController(animated: true)
                })
                self!.present(alert, animated: true)
            }
            updateAddressViewModel.updateAddressInModel(customerAccessToken: customerAccessToken, address: address)
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
