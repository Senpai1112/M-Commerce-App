//
//  LoginCustomerViewController.swift
//  Shopify
//
//  Created by Rokaya El Shahed on 17/02/2025.
//

import UIKit

class LoginCustomerViewController: UIViewController {
    
    private let authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("Loading from LoginViewController")
        setupUI()
//        setupViewModelObservers()
//        loginButtonTapped()
    }
    
    private func setupViewModelObservers() {
        authViewModel.onLoginSuccess = { accessToken in
            DispatchQueue.main.async {
                print(" Customer Logged in Successfully!")
                print("   Access Token: \(accessToken.accessToken ?? "N/A")")
                
                //navigate to home and pass access token after merge
            }
        }
        
        authViewModel.onError = { errorMessage in
            DispatchQueue.main.async {
                print("Error Logging In: \(errorMessage)")
                self.showAlert(title: "Login Error", message:" \(errorMessage) email or password incorrect")
            }
        }
    }
    
    
    @objc private func loginButtonTapped() {
        let testEmail = emailTextField.text ?? ""
        let testPassword = passwordTextField.text ?? ""
        
        print(" Testing Customer Login...")
        authViewModel.loginCustomer(email: testEmail, password: testPassword)
        
        setupViewModelObservers()
    }
    
    @objc private func goToRegister() {
        let storyBoard = UIStoryboard(name: "Set3", bundle: nil)
        if let registerVC = storyBoard.instantiateViewController(withIdentifier: "registerVC") as? CustomerViewController {
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
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
        label.text = "Welcome Back\n Login & Buy Now"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .purple
        return label
    }()
    
   
    private let emailTextField = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.purple
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
        button.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        return button
    }()
    
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.tintColor = .purple
        // Add subviews
        self.view.addSubview(headerView)
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        // Enable Auto Layout
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            // Email
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Password
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Login Button
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Register Button
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
}
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


