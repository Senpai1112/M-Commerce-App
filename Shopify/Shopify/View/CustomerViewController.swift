//
//  CustomerViewController.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 17/02/2025.
//

import UIKit

class CustomerViewController: UIViewController {
    
    private let viewModel = CustomerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading from CustomerViewController")
        setupViewModelObservers()
        testCreateCustomer()
    }
    
    private func setupViewModelObservers() {
        viewModel.onCustomerCreated = { customer in
            DispatchQueue.main.async {
                print(" Customer Created Successfully:")
                print("   ID: \(customer.id ?? "N/A")")
                print("   Name: \(customer.firstName ?? "N/A") \(customer.lastName ?? "N/A")")
                print("   Email: \(customer.email ?? "N/A")")
                
               //navigate to login
            }
        }

        viewModel.onError = { errorMessage in
            DispatchQueue.main.async {
                print(" Error Creating Customer: \(errorMessage)")
                self.showAlert(title: "Error", message: "\(errorMessage) \n Please try another email.")
            }
        }
    }
    
    private func testCreateCustomer() {
        let testCustomerId = "123456"  // dummy
                  let firstName = "John"
                  let lastName = "Doe"
                  let email = "johnnn.doen@example.com"
                  let password = "securepassword123"

                  viewModel.createCustomer(id: testCustomerId, firstName: firstName, lastName: lastName, email: email, password: password)
    }

    // Helper function to show alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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


