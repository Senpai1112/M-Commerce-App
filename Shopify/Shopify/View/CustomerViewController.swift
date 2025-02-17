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
            print("loading from customerViewController")
            setupViewModelObservers()
            testCreateCustomer() //  Call the test function
        }
        
        private func setupViewModelObservers() {
            viewModel.onCustomerCreated = { customer in
                DispatchQueue.main.async {
                    print(" Customer Created Successfully:")
                    print("   ID: \(customer.id ?? "N/A")")
                    print("   Name: \(customer.firstName ?? "N/A") \(customer.lastName ?? "N/A")")
                    print("   Email: \(customer.email ?? "N/A")")
                }
            }

            viewModel.onError = { errorMessage in
                DispatchQueue.main.async {
                    print(" Error Creating Customer: \(errorMessage)")
                }
            }
        }
        
        private func testCreateCustomer() {
            let testCustomerId = "123456"  // Shopify generates IDs automatically, you may not need this
            let firstName = "John"
            let lastName = "Doe"
            let email = "john.doen@example.com"
            let password = "securepassword123"

            viewModel.createCustomer(id: testCustomerId, firstName: firstName, lastName: lastName, email: email, password: password)
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


