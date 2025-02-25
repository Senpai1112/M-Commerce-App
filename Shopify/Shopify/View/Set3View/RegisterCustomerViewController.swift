//
//  CustomerViewController.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 17/02/2025.
//

import UIKit
import FirebaseAuth

class CustomerViewController: UIViewController {
///
    private let viewModel = CustomerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("Loading from CustomerRegisterViewController")
       // setupViewModelObservers()
       // testCreateCustomer()
    }
    
//    @objc private func registerButtonTapped() {
//        
//        testCreateCustomer()
//        
//        viewModel.onCustomerCreated = { customer in
//            DispatchQueue.main.async {
//                print(" Customer Created Successfully:")
//                print("   ID: \(customer.id ?? "N/A")")
//                print("   Name: \(customer.firstName ?? "N/A") \(customer.lastName ?? "N/A")")
//                print("   Email: \(customer.email ?? "N/A")")
//
//               //navigate to login
//                let storyBoard = UIStoryboard(name: "Set3", bundle: nil)
//                if let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginVC") as? LoginCustomerViewController {
//                    loginVC.customerId = customer.id ?? ""
//                    self.navigationController?.pushViewController(loginVC, animated: true)
//                }
//                
//            }
//        }
//
//        viewModel.onError = { errorMessage in
//            DispatchQueue.main.async {
//                print(" Error Creating Customer: \(errorMessage)")
//                self.showAlert(title: "Error", message: "\(errorMessage) \n Please try again.")
//            }
//        }
//     
//    }
    @objc private func registerButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
                 let password = passwordTextField.text, !password.isEmpty else {
               showAlert(title: "Error", message: "Please enter a valid email and password.")
               return
           }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error registering user: \(error.localizedDescription)")
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
                return
            }

            guard let user = Auth.auth().currentUser else { return }
            user.sendEmailVerification { error in
                if let error = error {
                    DispatchQueue.main.async {
                        print("Error sending verification email: \(error.localizedDescription)")
                        self.showAlert(title: "Error", message: "Could not send verification email. Please try again.")
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.showAlert(title: "Verification Required", message: "A verification email has been sent to \(email). Please verify your email before proceeding.")
                }
                
                self.checkEmailVerification(user: user)
            }
        }
    }
    func checkEmailVerification(user: User) {
        let timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            user.reload { error in
                if let error = error {
                    print("Error reloading user: \(error.localizedDescription)")
                    return
                }

                if user.isEmailVerified {
                    timer.invalidate()  // Stop checking
                    print("Email verified! Proceeding to customer creation.")

                    
                    self.createCustomer()
                }
            }
        }
    }
    func createCustomer() {
        testCreateCustomer()
        
        viewModel.onCustomerCreated = { customer in
            DispatchQueue.main.async {
                print(" Customer Created Successfully:")
                print("   ID: \(customer.id ?? "N/A")")
                print("   Name: \(customer.firstName ?? "N/A") \(customer.lastName ?? "N/A")")
                print("   Email: \(customer.email ?? "N/A")")

                // Navigate to Login
                let storyBoard = UIStoryboard(name: "Set3", bundle: nil)
                if let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginVC") as? LoginCustomerViewController {
                    loginVC.customerId = customer.id ?? ""
                    loginVC.customerName = "\(customer.firstName ?? "N/A") \(customer.lastName ?? "N/A")"
                    loginVC.customerEmail = "\(customer.email ?? "N/A")"
                  //  self.navigationController?.pushViewController(loginVC, animated: true)
                    self.showLoginAlert()
                }
            }
        }

        viewModel.onError = { errorMessage in
            DispatchQueue.main.async {
                print("Error Creating Customer: \(errorMessage)")
                self.showAlert(title: "Error", message: "\(errorMessage) \n Please try again.")
            }
        }
    }

    
    @objc private func loginButtonTapped(){
        let storyBoard = UIStoryboard(name: "Set3", bundle: nil)

        if let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginVC") as? LoginCustomerViewController {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    func showLoginAlert() {
            let alert = UIAlertController(title: "Alert", message: "Email Verified Thanks! Please Log In", preferredStyle: .alert)
            let loginAction = UIAlertAction(title: "Log In", style: .default) { _ in
                let storyBord = UIStoryboard(name: "Set3", bundle: nil)
                let loginVC = storyBord.instantiateViewController(withIdentifier: "loginVC") as! LoginCustomerViewController
                self.navigationController?.pushViewController(loginVC, animated: true)        }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(loginAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    
//    private func setupViewModelObservers() {
//        viewModel.onCustomerCreated = { customer in
//            DispatchQueue.main.async {
//                print(" Customer Created Successfully:")
//                print("   ID: \(customer.id ?? "N/A")")
//                print("   Name: \(customer.firstName ?? "N/A") \(customer.lastName ?? "N/A")")
//                print("   Email: \(customer.email ?? "N/A")")
//                
//               //navigate to login
//            }
//        }
//
//        viewModel.onError = { errorMessage in
//            DispatchQueue.main.async {
//                print(" Error Creating Customer: \(errorMessage)")
//                self.showAlert(title: "Error", message: "\(errorMessage) \n Please try another email.")
//            }
//        }
//    }
    
    private func testCreateCustomer() {
        let testCustomerId = "123456"  // dummy
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

                  viewModel.createCustomer(id: testCustomerId, firstName: firstName, lastName: lastName, email: email, password: password)
    }

    // Helper function to show alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
           let imageView = UIImageView(image: UIImage(named: "shopping_banner")) // Add this image to Assets
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           return imageView
       }()
       
       private let titleLabel: UILabel = {
           let label = UILabel()
           label.text = "Create your account\n& Shop Today"
           label.font = UIFont.boldSystemFont(ofSize: 22)
           label.textAlignment = .center
           label.numberOfLines = 2
           label.textColor = .purple
           return label
       }()
       
       private let firstNameTextField = CustomTextField(placeholder: "First Name")
       private let lastNameTextField = CustomTextField(placeholder: "Last Name")
       private let emailTextField = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
       private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
       private let confirmPasswordTextField = CustomTextField(placeholder: "Confirm Password", isSecure: true)
       
       private let registerButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Register", for: .normal)
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
           button.setTitleColor(.white, for: .normal)
           button.backgroundColor = UIColor.purple
           button.layer.cornerRadius = 10
           button.layer.shadowOpacity = 0.3
           button.layer.shadowRadius = 5
           button.layer.shadowOffset = CGSize(width: 0, height: 3)
           button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
           return button
       }()
       
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Already have account? Click to Login", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor.purple
//        button.layer.cornerRadius = 10
//        button.layer.shadowOpacity = 0.3
//        button.layer.shadowRadius = 5
//        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
  
    
    
       private func setupUI() {
           view.backgroundColor = .systemGray6

           //self.navigationItem.hidesBackButton = true
           //self.navigationController?.navigationBar.tintColor = .purple

           
           // Add subviews
           self.view.addSubview(headerView)
           view.addSubview(backgroundImageView)
           view.addSubview(titleLabel)
           view.addSubview(firstNameTextField)
           view.addSubview(lastNameTextField)
           view.addSubview(emailTextField)
           view.addSubview(passwordTextField)
           view.addSubview(confirmPasswordTextField)
           view.addSubview(registerButton)
           view.addSubview(loginButton)

           
           // Enable Auto Layout
           backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
           lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
           emailTextField.translatesAutoresizingMaskIntoConstraints = false
           passwordTextField.translatesAutoresizingMaskIntoConstraints = false
           confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
           registerButton.translatesAutoresizingMaskIntoConstraints = false
           loginButton.translatesAutoresizingMaskIntoConstraints = false

           // Constraints
           NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80),
               // Background Image
               backgroundImageView.topAnchor.constraint(equalTo:  headerView.bottomAnchor, constant: 10),
               backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               backgroundImageView.heightAnchor.constraint(equalToConstant: 180),
               
               // Title Label
               titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 10),
               
               // First Name
               firstNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
               firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
               
               // Last Name
               lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
               lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
               
               // Email
               emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
               emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               emailTextField.heightAnchor.constraint(equalToConstant: 50),
               
               // Password
               passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
               passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               passwordTextField.heightAnchor.constraint(equalToConstant: 50),
               
               // Confirm Password
               confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
               confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
               
               // Register Button
               registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
               registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Login Button
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
           ])
       }
          
         
      }

      //  Custom TextField
      class CustomTextField: UITextField {
          init(placeholder: String, keyboardType: UIKeyboardType = .default, isSecure: Bool = false) {
              super.init(frame: .zero)
              
              self.placeholder = placeholder
              self.keyboardType = keyboardType
              self.isSecureTextEntry = isSecure
              
              self.borderStyle = .none
              self.textColor = .black
              self.font = UIFont.systemFont(ofSize: 16)
              self.autocapitalizationType = .none
              self.backgroundColor = UIColor(white: 1, alpha: 0.1)
              self.layer.cornerRadius = 10
              self.layer.borderColor = UIColor.purple.cgColor
              self.layer.borderWidth = 1
              self.setLeftPadding(12)
          }
          
          required init?(coder: NSCoder) {
              fatalError("init(coder:) has not been implemented")
          }
      }
extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
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


